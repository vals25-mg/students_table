package com.exemple.test;

import com.exemple.util.DBConnection;
import com.exemple.model.VInscription;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestSelect {
    public static void main(String[] args) {
        List<VInscription> resultats = new ArrayList<>();

        String sql = "SELECT * FROM v_inscriptions";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

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
                resultats.add(v);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Affichage
        for (VInscription v : resultats) {
            System.out.println(v.getNom() + " (" + v.getFiliereNom() + ") - Moyenne : " + v.getMoyenne());
        }
    }
}
