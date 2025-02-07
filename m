Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6B18CBFC
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915294; cv=none; b=sq6EQmUFl/pebxrjVt3q0c8WRsN7pe0fUZ2x9T/rpyly4yz1PBadiHykD9JY15+0Uqw8Oke2SXqkuVyE4BTgVCrTKZ6/uxhx8CUueC/JmjVekgyqpcp6pW2eyEGN39JTar/tp0BEuOJn43iXB+5BNGeRREAWaqjJnjwHcdlv1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915294; c=relaxed/simple;
	bh=+1Sc8DvEXSqZhxSPhaoZkti61/HFD7B/mhsc91OQR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0pxZB9v9UWs9NAcJsHCVm7yAuZdQLViliprqGmjxx3YQKtvXvX0m8A38VElPZFx7E4bYgFB9tMbB0bPjzqIx39oZEYu0BfeKEtMFERASayrHIYE6CRVPz3IlX6RujQSb+gqMe70ZjF0DhG64OdO8Mt86qymkZr8tVvH6dgoT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h00gLq/4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h00gLq/4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so13748436d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738915292; x=1739520092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53rCUEYLoP6SzGQ7dltS09SOj08LJRV41NYySfcgmkU=;
        b=h00gLq/4BHkrGLsQbD+eQFL+zXZcdYJg/nNfz3jfhyjbKJRsU38zlizAKV1dL0ypAX
         uEDtzv3OVKjH2YTXcToeWDv6CQuF+63K1KYatBacD0UpAEsfsfwdufuET4X6p8iKFDpH
         puUyfpxmfQ54a7TFNVU7MkaXlig1f4lWRpzMFjDJtS8+4NQG1rhzFnCMuptH5NVP9WXZ
         5UbMXAbsxbeSO5Yxgr/h/XmlPxoE1UGJUYmep+EfVK1HFUkaV1eOLN1Uy7yD8mz3prj1
         6h94jvBfSxzun92cm0+1a9i6pBEZMUkOQgiahYGzlHuDzqcCLoRaD13VJ8us/Tb3FOH2
         S1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915292; x=1739520092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53rCUEYLoP6SzGQ7dltS09SOj08LJRV41NYySfcgmkU=;
        b=thZa7twYXQyUIIVCUvSqYZKEhYqua0YluJx8RR3FvH2fL4FmhhBAYA/l0t0OWyYPWk
         UNDXEHFCOSdbmTf4HHftGxnjje0gfEIcUcODQ8B6xaw3WgGvwSBqPPyB0aVNUCp8KwoM
         aOGEaD8YXx9v79lFGk1xmBRUTmQ2t/nrNy3BX4z1LgFBabLUQG2WWwxLrHobiP6WRKED
         Yw/AnDOLkW/wwKlwVEvcKYMQwTWbY9nr+T/zLuX4GF91l4B/cM2n5jNwKyoZEByo29tq
         HLzpMvkuwsL0LL9A0giCurpbdhisJ6c+L2LUOmFiWm+Al3mr5pPWpHSCkXCMoxfSXS3d
         ixNw==
X-Gm-Message-State: AOJu0YxhKtdm2E/wzmtvm8dF7MknoW6RUAOnKKPl1WoNfmkH7/LxVk1v
	AT+1JcsjmcBohV1wCHCJ1I+eMolQkAGbAk1AbYD0UNehbaBdqkCcJzfoNiJASks=
X-Gm-Gg: ASbGncvrpb6VOA0Oo4i1nInX8t+I7hTIQM1KZKkLWreJthFsDezYI28bO+SITxQhh6S
	efzIkb5rqHwBFiLIUWrwSvrshK7NibfRRKR7xduZdizo2POgUlX7aZUGo3rANni7baDFHA+PCp/
	CKvcett85KUvfrI7cIrWyzMOCORGnm4il+Y757HUzEtqZ8uTrnq5B9yXprLyKUbZ81Gmb+KVk23
	PIJJGyCetAhtwX5LnnrdiJixmd67vNpki7x/X0b+16sh70ynEF4qqAtwdnc7bvLy4fnj7GblSe+
	8rUdeJ2ZjOXUv/+oT0NJHX+2x/TtrywBWogD3Ml71iwWbSSDDT35QeZMx2DrMD2SUI2C09SCsQ=
	=
X-Google-Smtp-Source: AGHT+IHVh9GKjiTCyuhbzPrNi9cz7oIOwuNi4yAC6Z7SgEopNjBBBR7Jr4474gD2P2gHYgAE+nm67Q==
X-Received: by 2002:ad4:5ce8:0:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6e4456fb76amr33866786d6.31.1738915292012;
        Fri, 07 Feb 2025 00:01:32 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babc865sm14190686d6.101.2025.02.07.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:01:31 -0800 (PST)
Date: Fri, 7 Feb 2025 03:01:28 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-14-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		void __iomem *ras_base;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;

I'm fairly certain dport can come back here uninitialized, you
probably want to put this inside the `if (port)` block and 
pre-initialize dport to NULL.

> +		if (port)
> +			put_device(&port->dev);
> +		return ras_base;

You can probably even simplify this down to something like

		struct_cxl_dport *dport = NULL;

		port = find_cxl_port(&pdev->dev, &dport);
		if (port)
			put_device(&port->dev);

		return dport ? dport->regs.ras : NULL;


~Gregory
