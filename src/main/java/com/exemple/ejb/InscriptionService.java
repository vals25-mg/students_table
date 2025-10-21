package com.exemple.ejb;

import jakarta.ejb.Stateless;
import jakarta.annotation.Resource;
import javax.sql.DataSource;
import java.sql.*;
import java.util.*;
import com.exemple.model.VInscription;

@Stateless
public class InscriptionService {

    @Resource(lookup = "java:/jdbc/eleveDS")
    private DataSource ds;

    public List<VInscription> getClassements() throws SQLException {
        List<VInscription> list = new ArrayList<>();
        String sql = """
            SELECT id, id_eleve, nom, redoublement, id_filiere, filiere_nom, 
                   annee_debut, annee_fin, moyenne
            FROM v_inscriptions
            ORDER BY moyenne DESC, annee_debut DESC
        """;

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
                System.out.println("Connexion DS : " + ds);
                System.out.println("Exécution SQL...");
            while (rs.next()) {
                VInscription v = new VInscription();
                v.setId(rs.getInt("id"));
                v.setIdEleve(rs.getString("id_eleve"));
                v.setNom(rs.getString("nom"));
                v.setRedoublement(rs.getInt("redoublement"));
                v.setIdFiliere(rs.getInt("id_filiere"));
                v.setFiliereNom(rs.getString("filiere_nom"));
                v.setAnneeDebut(rs.getInt("annee_debut"));
                v.setAnneeFin(rs.getInt("annee_fin"));
                v.setMoyenne(rs.getDouble("moyenne"));
                list.add(v);
            }
        }
        System.out.println("Nombre de lignes récupérées: " + list.size());
        return list;
    }

    public VInscription getMajorDesMajors() throws SQLException {
        VInscription major = null;
        String sql = """
            SELECT id, id_eleve, nom, redoublement, id_filiere, filiere_nom, 
                   annee_debut, annee_fin, moyenne
            FROM v_inscriptions
            WHERE moyenne = (SELECT MAX(moyenne) FROM v_inscriptions)
            ORDER BY annee_debut DESC
            LIMIT 1
        """;

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            System.out.println(" Recherche MAJOR DES MAJORS...");
            if (rs.next()) {
                major = new VInscription();
                major.setId(rs.getInt("id"));
                major.setIdEleve(rs.getString("id_eleve"));
                major.setNom(rs.getString("nom"));
                major.setRedoublement(rs.getInt("redoublement"));
                major.setIdFiliere(rs.getInt("id_filiere"));
                major.setFiliereNom(rs.getString("filiere_nom"));
                major.setAnneeDebut(rs.getInt("annee_debut"));
                major.setAnneeFin(rs.getInt("annee_fin"));
                major.setMoyenne(rs.getDouble("moyenne"));
                System.out.println(" MAJOR TROUVÉ: " + major.getNom() + " - Moyenne: " + major.getMoyenne());
            } else {
                System.out.println(" Aucun major trouvé !");
            }
        }
        return major;
    }
}
