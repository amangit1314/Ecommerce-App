import {Column ,Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("user")
export class User { 
    @PrimaryGeneratedColumn("increment")
    id!: string;

    @Column({
        type: "varchar",
        length: 255,
        nullable: true,
        unique: false,
    })
    username!: string;

    @Column({
        type: "varchar",
        length: 255,
        nullable: true,
        unique: true,
    })
    useremail!: string;

    @Column({
        type: "varchar",
        length: 255,
        nullable: false,
        unique: true,
    })
    userpassword!: string;
}