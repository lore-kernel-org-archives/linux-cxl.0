Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDA19D067
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218592; cv=none; b=p/M5Ug+p5kEPvKDtxFYu/rvtdjlcdEKaCOSIut5P+cnUxobjRjcxxnqBSkbw/nxBSYLR+a4LgMGA9YjWCxfTvHq2hhFB0riFi+0gCdxJHuiWFpiyE8XTXvVr9SlkAw9ygjMlXKRABXd7l9Dk7LtKlwQ+rrsw2zJMIMwpXPTU53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218592; c=relaxed/simple;
	bh=zOVCuLqqp7lIFVY+RQFVpAD9kWvnhUx4b7NUg6zFx6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL5KToWj9X24iY5FIyMvMESMrsWF1q6djwEe0Rm+0fg9lCRDSbKVW/k75L8clXiBogRW0upXN6B+x4N1Ngu7EoqrCOKNKqNAxTltvb3ml1u48Bv3caopfsOG/bm4we7wFr22QnYCY366g6T7lPqNTUey/gxlW86WkWP4exlpSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L/AXbWI9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L/AXbWI9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e41e17645dso45120836d6.2
        for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739218590; x=1739823390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZaS9Q5ARi+stLwMR+ytvy82MSixmOKvEzop3aGNRg=;
        b=L/AXbWI929HQpvOIwDtqsnNvDhxPQC03FwUQYTXsRMF6RCCCtewcYho0K7iz+MpjLF
         NiGJ4D4j5cNKua6Ls61xNVYUlu7KrGJK6fYw5azWCjxOnonw/Ux+4tsInL5YFGZ3pLJd
         kvDfDZTeQA8sZgthFoAIa3kBhv1sB6qf9y+sLOassCZBoMGxh5hWIt5aVcjWs/o73Z7t
         oFC8wurl8W8yX2CDXgBhjewVUYHMSR1uxfw46Sn64PBOYaglri59PA31ExRjVDehhAhW
         fBahxbIxFu/92L0djMxEJd+qHFVbksAuF9sg4JmK79BpZ3PgLgPvh2KwIJBvCDEtvdsx
         y8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739218590; x=1739823390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmZaS9Q5ARi+stLwMR+ytvy82MSixmOKvEzop3aGNRg=;
        b=TlFfxKcqRD6CP3IdixFCFqj/75ji/+AOg9aAdwPw5CJnCmejcqnT8sW0EIDF3ND4Vo
         uFxwpnkzXcpYyULMzymEDs9ciQIq1/YZAZkALat9ULU9uSluTttp6zWXld/qRgn8f6C9
         py0uy3muEVCDguuxD8/pSqlPj7J9cbo7z3aRQ+YR2wUGKeiqJiLalAtYzVYRe4YmqIAk
         pUqb5XlKtqbVyzuIJN6Y1w+n76NPUnl6DsTMf0f8COj+m13BD4fat3/Ij3oHBt1+4vD9
         2NPnWu0TRNrWiRLZWCOahbImIps2vclvfsiYBdM/7yRDZL/YkUXxXoehaB4mUukM1JdI
         NQQg==
X-Gm-Message-State: AOJu0YyLrxwwINf7atp9rjswK8dJyMRQRdkrQBWMzLlnELoUPUrxYL6a
	DdoIjfj8kGeX6/FiIljS/EFSeeo/5E7yxTl7AwoAUJuHImHdr2eGibaTZAr0iZY=
X-Gm-Gg: ASbGncs84ixMu9jV2MG2BwIfdJLYbhsmLn81tOm2rylGhnPEkJysbTKmvhm5FIlQpRU
	AVvLJiVp8yePDdq+idhADJlnppvarNCYuc+ZvZgu1NYQFOKoKXlnuQipinFyA05gScxr+fGxUFD
	q8id2m0sOID0/bm0D8kKZWg1pWG66f68Z1TDHcQaUrwZlOSqIy6shw5GzYYI0X7o8dPqK5QQ21J
	8U40RHn82tuTK9xMQzrMMMHdu8WZA2ouGszwHDK7bpAVt+ludHn2dmRZYJECSshlq1fxzn4spFG
	anQw5e13ggTdxSMfL2G2TkpIJXjZSy3MZ+u/MnJny54d/RRmO6TJjzXVwqYVLTNJM34Yy6xzKg=
	=
X-Google-Smtp-Source: AGHT+IHaWy6OWyyGWl5uHJt1PdJryLmgsKNr7oFda7GMAIR7eYtWwDbpamF5pLaQI6ezCFdzn8zwsg==
X-Received: by 2002:a05:6214:234d:b0:6dd:d3b:de27 with SMTP id 6a1803df08f44-6e44561dda0mr199510966d6.18.1739218590061;
        Mon, 10 Feb 2025 12:16:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43bad58c0sm50428806d6.118.2025.02.10.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:16:29 -0800 (PST)
Date: Mon, 10 Feb 2025 15:16:27 -0500
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
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v6 09/17] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <Z6pem7NaFiBdcCxy@gourry-fedora-PF4VCD3F>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
 <20250208002941.4135321-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208002941.4135321-10-terry.bowman@amd.com>

On Fri, Feb 07, 2025 at 06:29:33PM -0600, Terry Bowman wrote:
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4af39abbfab3..0adebf261fe7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -652,7 +652,7 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -663,10 +663,8 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
> -		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>  		return;
> -	}
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
>  	if (is_cxl_memdev(cxl_dev))


This seems like where you actually wanted this original change:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index aa855c2068e0..a0c78655a8af 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -714,7 +714,7 @@ void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
                                 void __iomem *ras_base)
 {
        void __iomem *addr;
@@ -725,15 +725,19 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 
        addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
        status = readl(addr);
-       if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-               writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-               trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
-       }
+       if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+               return;
+       writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+       if (is_cxl_memdev(dev))
+               trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+       else if (is_cxl_port(dev))
+               trace_cxl_port_aer_correctable_error(dev, status);
 }
