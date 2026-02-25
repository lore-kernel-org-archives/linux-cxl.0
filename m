Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BB3AEF34
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035269; cv=none; b=jTz4mbnOxAMGeOqoA63OnWeuk0Mu798L/ToTfyPQ0wh+13huvRp+T6+ZYFoNNS33Dcn6EsXB48s0+voSGq7Z5/9N6XzFpWFoIEUtgs6KhSLKo3tI8T7x7JZzayepni778QJzxM8o6OnrFmPzVKtLf9ix6Ia1NSaNOezgwhneKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035269; c=relaxed/simple;
	bh=EpFQL74OTnCGsr/UxnttF5RgnXfWrVUAr7G0iooCYF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peiA7e+Qu6ps36ULVB2WXdy0wi9tS8f1yZOIN+fzToB9N3uHqac7q2HerZWbBLgHil8K3sVimtUcdvwwDWkOuIrLeB4B/TQ8tZ4QkCr4PWZM/KJbn2MHRYwY35VHNnsN1RJYsNyNhkMQHGxDcdlwXBqtmkFiHb62YMKqD18PrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vCpHFhm/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vCpHFhm/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c7199e7f79so906670185a.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772035267; x=1772640067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lw8S21s9c8Va2Ap4e4xPzxfAvQSYFHTRNV+BRwWmpr8=;
        b=vCpHFhm/6SM28PgJiRXf3iNpu8dR2FAw9RI55y1iWrwd+pwqypCnqf5orjDf2aobZ6
         EKaItSgWwpcWpY0sIMF19wNA4hZkHeK8Az/DmonbMdIGfc5q9YeiUdju2h0s+sXFSgPz
         JPaBf2VrFqIbKbq/X7JzJg7rLJsijSai/qSmS+akFlfHvDXTVCYQt1u/2D8m+NO/hPAM
         V+hFDVL3LOHqpB52h4JqZ4ZYNbGBgb9aFUm7HwECUHGAN5pz8o+2ZQ03xrvr/EUEge9g
         6+EMUzsiOtVeQH+Qjck/nqZ1cgG4lSO7FQBA/pOljX4MkYLxjxvRlEITgU2KB3yKQQ52
         JQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772035267; x=1772640067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw8S21s9c8Va2Ap4e4xPzxfAvQSYFHTRNV+BRwWmpr8=;
        b=NR2IaZ4nazXJ3xLGC759jbfTGgXwR3ENejAONUBEON7SWK/+Aeu+MuI7wszM5jURWH
         A9M3VG6L0Hp/PCPpKTbAljrqK/7Osa/ys4eIShIUsCvg4d1ahHxo8Cm4+AGCFlkUY26+
         1OQXqY5J89D0AaLNHlWL4ZiauZYXaqRqXtCff5ksGkPosZYg/YHM0Mkt0yPth+o4AGno
         IcwlZgbWygsJ+7kqv15P1SUXbocf/rpIaPYJs1t61LmM5kZDvQSZ4soHMPe/iPrSLJMB
         eOD3W8AbmJVT3bAa/Sy5bahNUftY88Ma3FyEVRbVl/15D63nqi9roSdUK+LvybnYHR8T
         dYCg==
X-Gm-Message-State: AOJu0YyBMoETwqu6Y9tNMScaS5+bg+0AmDVEuCNERvvt5jR0Z92SladD
	vSoa6Yg/MSZyT4aQ+cTz5x4qHwtWONx1B6/HhOGq3W75afBXDXdwaBSneDqliHkPzDc=
X-Gm-Gg: ATEYQzwhsPGw9y+r2/Q2obc7mRDHTF3arROJo+VfjYvhJzBDlIuX4n9jSDojIsSXD/Y
	NS95ITd06sPR+QxcUDC6orwYf7kmp3UpGv5oJAja8/qEX4ezBeT8qW5y0n+dPw08ZhsMX8QtfXT
	j53hMvkl4v5K+MlWB9rgT02uJlOGZdN5oUWU/g20Ytvk3hLSyEeMxYXO2ehU9kqRD/n5iCK0UIn
	Smtk+UdEaD4f7t7Dya4e1cntWLhGIfzoGsI31m6Gi7HsNCOjSipNWWmgxzz90/xFVYBR7DHIvPX
	KHzMoXn2vxqksNqyRFaSU93ciIguuGcxKkEExOKdOT32A0LejZusedlDpeQj2QE+uhfbV+PeqVF
	+5uYvBO8hgSJWL0h4HC2uWImSj0kuIcJIkC+5iwhTP1f4sJFpg5lpgkiz+Ka8vsL+/kZA8uiBVR
	1ZrFSKdP3MzsMFkqoPOqjZjJ8Cf5lLFGeVShsiTfgX6N+VhLEVMBzTR8ZHjXuzdawMNe4dd7LH8
	q+gDpu5PA==
X-Received: by 2002:a05:620a:d8a:b0:8a3:1b83:1036 with SMTP id af79cd13be357-8cbbcf7e84amr140511585a.29.1772035241943;
        Wed, 25 Feb 2026 08:00:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1202e2sm1282073285a.44.2026.02.25.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:00:41 -0800 (PST)
Date: Wed, 25 Feb 2026 11:00:39 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 3/3] cxl: Move pci generic code
Message-ID: <aZ8cp4_xhEspZxwX@gourry-fedora-PF4VCD3F>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>

On Wed, Feb 25, 2026 at 12:14:30PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
> initialization.
> 
> In preparation for type2 support, move helper functions from cxl/pci.c to
> cxl/core/pci.c in order to be exported and used by type2 drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

One note for existing code so not a blocker (not really a bug)

Reviewed-by: Gregory Price <gourry@gourry.net>

> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map,
> +				  struct cxl_dport *dport)
> +{
... snip ...
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
... snip ...
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map)
> +{
... snip ...
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) =
> +			cxl_pci_find_port(pdev, &dport);
> +		if (!port)
> +			return -EPROBE_DEFER;
> +
> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> +		if (rc)
> +			return rc;
> +

we call cxl_pci_find_port() here twice on the same pdev and pass the
dport into the second caller.

Can something actually change between these two secnarios?  Seems like
we can just drop the check in cxl_rcrb_get_comp_regs?

~Gregory

---

cxl/pci: Remove redundant cxl_pci_find_port() call in cxl_rcrb_get_comp_regs()

Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
dport parameter directly. The caller has already validated the port is
non-NULL before invoking this function.

Signed-off-by: Gregory Price <gourry@gourry.net>

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c32cc62c501d..d1f487b3d809 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
                .resource = CXL_RESOURCE_NONE,
        };

-       struct cxl_port *port __free(put_cxl_port) =
-               cxl_pci_find_port(pdev, &dport);
-       if (!port)
-               return -EPROBE_DEFER;
-
        component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
        if (component_reg_phys == CXL_RESOURCE_NONE)
                return -ENXIO;

