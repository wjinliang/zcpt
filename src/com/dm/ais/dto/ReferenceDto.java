package com.dm.ais.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "ais_reference")
public class ReferenceDto implements Serializable {

	private static final long serialVersionUID = -8174089656316348596L;

	//1_1  或 1_2
	private String reference;
	
	private String startSlotA;
	
	private String blockSizeA;
	
	private String incrementA;
	
	private String startSlotB;
	
	private String blockSizeB;
	
	private String incrementB;
	
	//4 和 20
	private String configuration;

	@Column(name = "reference")
	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	@Column(name = "startSlotA")
	public String getStartSlotA() {
		return startSlotA;
	}

	public void setStartSlotA(String startSlotA) {
		this.startSlotA = startSlotA;
	}

	@Column(name = "blockSizeA")
	public String getBlockSizeA() {
		return blockSizeA;
	}

	public void setBlockSizeA(String blockSizeA) {
		this.blockSizeA = blockSizeA;
	}

	@Column(name = "incrementA")
	public String getIncrementA() {
		return incrementA;
	}

	public void setIncrementA(String incrementA) {
		this.incrementA = incrementA;
	}

	@Column(name = "startSlotB")
	public String getStartSlotB() {
		return startSlotB;
	}

	public void setStartSlotB(String startSlotB) {
		this.startSlotB = startSlotB;
	}

	@Column(name = "blockSizeB")
	public String getBlockSizeB() {
		return blockSizeB;
	}

	public void setBlockSizeB(String blockSizeB) {
		this.blockSizeB = blockSizeB;
	}

	@Column(name = "incrementB")
	public String getIncrementB() {
		return incrementB;
	}

	public void setIncrementB(String incrementB) {
		this.incrementB = incrementB;
	}

	@Column(name = "configuration")
	public String getConfiguration() {
		return configuration;
	}

	public void setConfiguration(String configuration) {
		this.configuration = configuration;
	}
	
}
