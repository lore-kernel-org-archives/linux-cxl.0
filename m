Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803597080E;
	Thu, 29 Jan 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714167; cv=pass; b=DkLbe9CgCQqJ1jh3wUpWpvL1ETz9dmYmgvugwivI/LpDRXKXurAnvIeLP+uShv9EemNDiy2ddazNqWshtXbFF7ZFU1LcOsG3OeAPSudemK22preMaNGxTn4Cn9Lv+LIn0BFzmjpK10NcMgU+hx5TiOlSyQVM+cZbKnw1AVnUsTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714167; c=relaxed/simple;
	bh=wb4ij8yJBB4sMVQK75jd7WJbgtdClEC8DGRswtM/TE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngY4n4Q3jz3PM2INNV31VkHEPrsjOKmm3/ortHGTAxzgLCh1dHiVHymvSzZyTVuq4TjuFHAuWKhg18lEl6uF5l3ufIzYrrcFdq6DC9Mvw96CqRgtlwLNkz83i+QOkSwc45gWE4rNr6hE507YPX6GNgGVjadjcfqrxE+cbeD/M8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eT++y+jf; arc=pass smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eT++y+jf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9A34F762DF2;
	Thu, 29 Jan 2026 19:10:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-123-102-161.trex-nlb.outbound.svc.cluster.local [100.123.102.161])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3CF2F7630DB;
	Thu, 29 Jan 2026 19:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1769713843;
	b=mtBq8eKZFrsymvnoIhddc7EN1ZseqYAVHwS6kZIBPJw8PDVHS0+ho8/UN3QNilSCI69hTS
	p+d3AouT72WC1yI5VySGuDluyCQKJkjpeipWu9gIMHTxhc1XPSLPH4n+ySF2Z7u9xll+g3
	5nCNdTQvGlhif/Xz4ru93UUkeNZoEkEmU8/gxJ3tivTpHb8AUaDA8JVknumqREt/2cPgcY
	QA9+9h1ih/I7T9RQV2TbOHuZzLVkRVh9DzLKRai384gbKg/PhcnFeNSJE7AydVxEkk4+K7
	4q219cZKBlR49RK848WIoYH7OaCvoM52xAcDTaKLdFmPxgQm/Jh+wjXKuFU1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1769713843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=drza7C4nb+5XU0DQB9t0KUG8UgYZ0/ViKC2FCYijLw8=;
	b=hSLvpCyJtx+WkmcYqQs2IjVcC7hQuA/nnMUDHTf56F6Pd898ZAwcuB/QebfvKWiWhuW0cv
	/Dy2JS6T3hDmCXfazsc6+wRB1x3VzzjezNZOxFoUunzwvJB2EFHwQ8ON8QhVI1P6EVWXpK
	X4wrO13+UJLp8t+XHYowL+0FiGHpF+wWY/XDlYYl3jCxms//+D5RxTSCeHUGpJu80PHkzI
	e88HJsfWsXVPPbanpMtRwO9rdlvC80fLTiTeqQvAHD7gGzvEgspAwIHfz8fXhZ1ZaR6OzH
	ht6i95eXIZp//VPg9LGBFjLS8qf8U1ld7T78HvgcdhYisdmUu0hgKO7ZWYX9Ng==
ARC-Authentication-Results: i=1;
	rspamd-5b979ccf89-jkm92;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Trail: 4d7c94845e31709d_1769713844474_3466359837
X-MC-Loop-Signature: 1769713844474:2659033444
X-MC-Ingress-Time: 1769713844474
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.102.161 (trex/7.1.3);
	Thu, 29 Jan 2026 19:10:44 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4f27yV2xgZz1P3;
	Thu, 29 Jan 2026 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1769713843;
	bh=drza7C4nb+5XU0DQB9t0KUG8UgYZ0/ViKC2FCYijLw8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=eT++y+jfHt/N6Kj5JjPiOBV3UJvGrrxvTqblkrVVwpbckl0I4VUz3YnfPq7RAEl9B
	 P3pTh/rkzxYHCAP1Us7vRaogBsI3CjwH0QDo+dW6mIDWrYBFBjuLE4uNdDbsphKRJb
	 a7hrS3hiY4Qs35MvkFbgFDxhwxCzyYEoFePlWvHMBW2NMHN7dHrsTsJJzPBZT794wX
	 w78waFmVLLS+UqsTPUiwO2ccw3Px1bPXAsjT1O1XEpFQNADQaW5P0yTsCgcjWKg2Mf
	 LGUFb773hdHb1XTp5SzAdqDXMf4bGcEeekGGwcLFqSb0EfzqP2FV+hsA/yuS69A9fe
	 Ypx+PEnQgpOQQ==
Date: Thu, 29 Jan 2026 11:10:39 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, anisa.su@samsung.com,
	dongjoo.seo1@samsung.com, s.neeraj@samsung.com
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <20260129191039.kodgkum445ws5rhs@offworld>
References: <20260113202138.3021093-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Tue, 13 Jan 2026, Gregory Price wrote:

>The CXL driver presently has 3 modes of managing a cxl_region:
>  - no specific driver (bios-onlined SystemRAM)
>  - dax_region (all other RAM regions, for now)
>  - pmem_region (all PMEM regions)
>
>Formalize these into specific "region drivers".

I think your overall idea of these region driver backends to isolate use
cases makes a lot of sense and helps untangle things. This series is a good
step and nicely moves ad-hoc complexity out of region.c.

>
>enum cxl_region_driver {
>	CXL_REGION_DRIVER_NONE,
>	CXL_REGION_DRIVER_DAX,
>	CXL_REGION_DRIVER_PMEM
>};
>
>$cat regionN/region_driver
>[none,dax,pmem]
>
>The intent is to clarify how to to add additional drivers (sysram,
>dynamic_capacity, etc) in the future, and to allow switching the
>driver selection via a sysfs entry `regionN/region_driver`.
>
>All RAM regions will be defaulted to CXL_CONTROL_DAX.

s/CXL_CONTROL_DAX/CXL_REGION_DRIVER_DAX?

>
>Auto-regions will either be static sysram (BIOS-onlined) and has no
>region controller associated with it - or if the SP bit was set a
>DAX device will be created.  This will be discovered at probe time.
>
>Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/region.c | 113 ++++++++++++++++++++++++++++++--------
> drivers/cxl/cxl.h         |   8 +++
> 2 files changed, 98 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index ae899f68551f..f8262d2169ea 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -626,6 +626,57 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> }
> static DEVICE_ATTR_RO(mode);
>
>+static ssize_t region_driver_show(struct device *dev,
>+				  struct device_attribute *attr,
>+				  char *buf)
>+{
>+	struct cxl_region *cxlr = to_cxl_region(dev);
>+	const char *desc;
>+
>+	switch (cxlr->driver) {
>+	case CXL_REGION_DRIVER_NONE:
>+		desc = "none";
>+		break;
>+	case CXL_REGION_DRIVER_DAX:
>+		desc = "dax";
>+		break;
>+	case CXL_REGION_DRIVER_PMEM:
>+		desc = "pmem";
>+		break;
>+	}
>+
>+	return sysfs_emit(buf, "%s\n", desc);
>+}
>+
>+static ssize_t region_driver_store(struct device *dev,
>+				   struct device_attribute *attr,
>+				   const char *buf, size_t len)
>+{
>+	struct cxl_region *cxlr = to_cxl_region(dev);
>+	struct cxl_region_params *p = &cxlr->params;
>+	int rc;
>+
>+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>+		return rc;
>+
>+	if (p->state >= CXL_CONFIG_COMMIT)
>+		return -EBUSY;
>+
>+	/* PMEM drivers cannot be changed */
>+	if (cxlr->mode == CXL_PARTMODE_PMEM)
>+		return -EBUSY;
>+
>+	/* NONE type is not a valid selection for manually probed regions */
>+	if (sysfs_streq(buf, "dax"))
>+		cxlr->driver = CXL_REGION_DRIVER_DAX;
>+	else
>+		return -EINVAL;
>+
>+	return len;
>+}
>+static DEVICE_ATTR_RW(region_driver);
>+
> static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> {
> 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>@@ -772,6 +823,7 @@ static struct attribute *cxl_region_attrs[] = {
> 	&dev_attr_size.attr,
> 	&dev_attr_mode.attr,
> 	&dev_attr_extended_linear_cache_size.attr,
>+	&dev_attr_region_driver.attr,
> 	NULL,
> };
>
>@@ -2599,6 +2651,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> 	cxlr->mode = mode;
> 	cxlr->type = type;
>
>+	/*
>+	 * PMEM regions only have 1 driver: pmem_region
>+	 * RAM regions default to DAX, but if the memory is already onlined by
>+	 * BIOS as 'System-RAM', the DAX driver will be dropped during probe.
>+	 */
>+	if (mode == CXL_PARTMODE_PMEM)
>+		cxlr->driver = CXL_REGION_DRIVER_PMEM;
>+	else
>+		cxlr->driver = CXL_REGION_DRIVER_DAX;
>+
> 	dev = &cxlr->dev;
> 	rc = dev_set_name(dev, "region%d", id);
> 	if (rc)
>@@ -3951,33 +4013,38 @@ static int cxl_region_probe(struct device *dev)
> 			return rc;
> 	}
>
>-	switch (cxlr->mode) {
>-	case CXL_PARTMODE_PMEM:
>-		rc = devm_cxl_region_edac_register(cxlr);
>-		if (rc)
>-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
>-				cxlr->id);
>+	if (cxlr->mode > CXL_PARTMODE_PMEM) {
>+		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>+			cxlr->mode);
>+		return -ENXIO;
>+	}
>
>-		return devm_cxl_add_pmem_region(cxlr);
>-	case CXL_PARTMODE_RAM:
>-		rc = devm_cxl_region_edac_register(cxlr);
>-		if (rc)
>-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
>-				cxlr->id);
>+	/*
>+	 * The region can not be managed by CXL if any portion of
>+	 * it is already online as 'System RAM'.
>+	 */
>+	if (walk_iomem_res_desc(IORES_DESC_NONE,
>+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>+				p->res->start, p->res->end, cxlr,
>+					is_system_ram) > 0) {
>+		cxlr->driver = CXL_REGION_DRIVER_NONE;
>+		return 0;
>+	}
>
>-		/*
>-		 * The region can not be manged by CXL if any portion of
>-		 * it is already online as 'System RAM'
>-		 */
>-		if (walk_iomem_res_desc(IORES_DESC_NONE,
>-					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>-					p->res->start, p->res->end, cxlr,
>-					is_system_ram) > 0)
>-			return 0;
>+	rc = devm_cxl_region_edac_register(cxlr);
>+	dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d %s\n",
>+			cxlr->id, rc ? "failed" : "succeeded");
>+
>+	switch (cxlr->driver) {
>+	case CXL_REGION_DRIVER_NONE:
>+		return 0;
>+	case CXL_REGION_DRIVER_DAX:
> 		return devm_cxl_add_dax_region(cxlr);
>+	case CXL_REGION_DRIVER_PMEM:
>+		return devm_cxl_add_pmem_region(cxlr);
> 	default:
>-		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>-			cxlr->mode);
>+		dev_dbg(&cxlr->dev, "unsupported region driver: %d\n",
>+			cxlr->driver);
> 		return -ENXIO;
> 	}
> }
>diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>index ba17fa86d249..e8256099de29 100644
>--- a/drivers/cxl/cxl.h
>+++ b/drivers/cxl/cxl.h
>@@ -502,6 +502,13 @@ enum cxl_partition_mode {
> 	CXL_PARTMODE_PMEM,
> };
>
>+
>+enum cxl_region_driver {
>+	CXL_REGION_DRIVER_NONE,
>+	CXL_REGION_DRIVER_DAX,
>+	CXL_REGION_DRIVER_PMEM,
>+};
>+
> /*
>  * Indicate whether this region has been assembled by autodetection or
>  * userspace assembly. Prevent endpoint decoders outside of automatic
>@@ -543,6 +550,7 @@ struct cxl_region {
> 	struct device dev;
> 	int id;
> 	enum cxl_partition_mode mode;
>+	enum cxl_region_driver driver;
> 	enum cxl_decoder_type type;
> 	struct cxl_nvdimm_bridge *cxl_nvb;
> 	struct cxl_pmem_region *cxlr_pmem;
>-- 
>2.52.0
>
