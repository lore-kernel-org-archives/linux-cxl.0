Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2362EFD91;
	Thu, 29 Jan 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714180; cv=pass; b=gZ8seFpjIWm8ZCcKJX1tAU1uBvCI0jpdm+3geCo6IlLuecqz1+XhMy2Ri4/IcKT+YjQM+Tb7JU3QF/rz9EJb7fI43VFBG5FAOflIfCBePeNyVB0Plom0aDlC24gH+pTk5hBEblh+0p9SmImtxVCArAD/n6pLC1IaRxG44JeanZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714180; c=relaxed/simple;
	bh=e1h/wQew/ko6TA68Zes6S17UxhPEdV6T5UMPDM7FBSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrRaMqEbGPOQQ7faKYpuJLVU3YKLz8CrZ8xmvvOyGGDgXP13DCN9FblmY2sJ8wqvi4f+oACc1ma5BSlU0d5BzVk/SCBZgOj9D1k3Nmus82lTDDdus7frQo2bfPzNjyrQm3k8wthcDEbAAnJk+3I4h6Nt/cRd46aztklSmce+WOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ORSlzrQt; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ORSlzrQt"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 32234162B6C;
	Thu, 29 Jan 2026 19:16:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.96.80.125])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9DAC316324B;
	Thu, 29 Jan 2026 19:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1769714171;
	b=NTGlf5c3zSwO0JufUKgPPIoI2ZtZRFZ4E1PkL7Foe9ueEbGTWFrI8YT7ENGTZnjf1SJTJx
	xi4m635RQ6nWbyucsUtcxk+5I/hRjSnJ1isWgjnEiwclm/G8ZpWi3rEw/U0Im5ukAkdEQE
	PUUGvqdiUG5EzIaEMUoDPNwymtdROD7pgnX2bA4bLokr/Vlg3/1dGMiqfhNT9VSyx/ZBGz
	F3pOYFUHkV7xuzyfOVVFVfIJ+uYQ9HkN0emBFRU3Vjm/v1NDj09pSZ1eU4REO0iB0BFvW2
	GhD7zE7kG7ozVuRfNK+E++mXTUyaEE7CoFAkOrYzH0rykxhmlPFkJExSuQJDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1769714171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HBNlxMgZ8B9PiQIkHqPX3fRQN4053VxRRf7Q+7qacb8=;
	b=vEi42jlqYx8U+1dNVH98u0fXr/GkOUK86C3AAx4wYawjAh1dfxX/cVtu6k6YvC4sLcGOMN
	bBlM1CJGmZj4NJmP+MjNIHTj4xuLPAeI4mt1L034duGYG2ZJYLg5izeC7JUumY8/ZUcYS3
	ETLI12YmOLFklY4HzITYhDwl3X1WG1aCDEIR8O2UTlGKc+yz7RD8tTUkB8Gsfb3VuEc+zI
	U/kGifUORM4el6KmM3+vtZhYlx7EFNDkUwAFnsVHBznnKVGbUPAisNPMDBR5eH4/4RhWi2
	wT7J+4l3mkgIeooRMQL8IvO7dUy6GRfCEK+WYr6X2gVQ/UVk2C5w47ZBTl5zdg==
ARC-Authentication-Results: i=1;
	rspamd-c758cdf4d-bz5pc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Tangy: 5ea4e8713d6ec99a_1769714171959_1796030681
X-MC-Loop-Signature: 1769714171959:3783861741
X-MC-Ingress-Time: 1769714171959
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.80.125 (trex/7.1.3);
	Thu, 29 Jan 2026 19:16:11 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4f284p5qYyz1cp;
	Thu, 29 Jan 2026 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1769714171;
	bh=HBNlxMgZ8B9PiQIkHqPX3fRQN4053VxRRf7Q+7qacb8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ORSlzrQtn7X8lkhfjQSdYLSkRQE62U2yzhNWBoK7INIZm3R1Z6nwAtLXmjyhDnps4
	 QPePAkmPbYai4T39kRLc5Qs7xtZtrtOm+/InJGYkSq1Xi60HPnwp9HBM+br0nBB/zn
	 YTfMSc3fBbQsmyDCxg+j5cWPkdJF2VGVrBvLRxkLPdi6ZM56BaO+3mv/0C1TryAOJV
	 hnZ6e5Ld8V16qhz84IRlBDXelsVg8UrKu7O6ATsQCptNvtZNBVZZrtzcthMyXfPnKb
	 nEKanBA+PO9E2omvgVuEtDVtBn+e0DkzcVh/uP6k0KTz3UIy6a/maX9GV6ZKjVT3Zz
	 Ns5BCRjI3eB3Q==
Date: Thu, 29 Jan 2026 11:16:07 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, anisa.su@samsung.com,
	dongjoo.seo1@samsung.com, s.neeraj@samsung.com
Subject: Re: [PATCH v2 3/3] cxl/core/region: move dax region driver logic
 into dax_region
Message-ID: <20260129191607.axkkrion3zakb7pg@offworld>
References: <20260113202138.3021093-1-gourry@gourry.net>
 <20260113202138.3021093-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113202138.3021093-3-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Tue, 13 Jan 2026, Gregory Price wrote:

>Move the dax region driver logic from region.c into dax_region.c
>
>Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/Makefile     |   1 +
> drivers/cxl/core/core.h       |   1 +
> drivers/cxl/core/dax_region.c | 106 ++++++++++++++++++++++++++++++++++
> drivers/cxl/core/region.c     |  99 -------------------------------
> 4 files changed, 108 insertions(+), 99 deletions(-)
> create mode 100644 drivers/cxl/core/dax_region.c
>
>diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>index 23269c81fd44..36f284d7c500 100644
>--- a/drivers/cxl/core/Makefile
>+++ b/drivers/cxl/core/Makefile
>@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
> cxl_core-y += ras.o
> cxl_core-$(CONFIG_TRACING) += trace.o
> cxl_core-$(CONFIG_CXL_REGION) += region.o
>+cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
> cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
> cxl_core-$(CONFIG_CXL_MCE) += mce.o
> cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>index cd589e81f55e..3ea850408814 100644
>--- a/drivers/cxl/core/core.h
>+++ b/drivers/cxl/core/core.h
>@@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
> struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> 		   u64 dpa);
>+int devm_cxl_add_dax_region(struct cxl_region *cxlr);
> int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>
> #else
>diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
>new file mode 100644
>index 000000000000..d7c38447f816
>--- /dev/null
>+++ b/drivers/cxl/core/dax_region.c
>@@ -0,0 +1,106 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>+#include <linux/device.h>
>+#include <linux/slab.h>
>+#include <cxlmem.h>
>+#include <cxl.h>
>+#include "core.h"
>+
>+static void cxl_dax_region_release(struct device *dev)
>+{
>+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>+
>+	kfree(cxlr_dax);
>+}
>+
>+static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
>+	&cxl_base_attribute_group,
>+	NULL,
>+};
>+
>+const struct device_type cxl_dax_region_type = {
>+	.name = "cxl_dax_region",
>+	.release = cxl_dax_region_release,
>+	.groups = cxl_dax_region_attribute_groups,
>+};
>+
>+static bool is_cxl_dax_region(struct device *dev)
>+{
>+	return dev->type == &cxl_dax_region_type;
>+}
>+
>+struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>+{
>+	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
>+			  "not a cxl_dax_region device\n"))
>+		return NULL;
>+	return container_of(dev, struct cxl_dax_region, dev);
>+}
>+EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>+
>+static struct lock_class_key cxl_dax_region_key;
>+
>+static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>+{
>+	struct cxl_region_params *p = &cxlr->params;
>+	struct cxl_dax_region *cxlr_dax;
>+	struct device *dev;
>+
>+	guard(rwsem_read)(&cxl_rwsem.region);
>+	if (p->state != CXL_CONFIG_COMMIT)
>+		return ERR_PTR(-ENXIO);
>+
>+	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
>+	if (!cxlr_dax)
>+		return ERR_PTR(-ENOMEM);
>+
>+	cxlr_dax->hpa_range.start = p->res->start;
>+	cxlr_dax->hpa_range.end = p->res->end;
>+
>+	dev = &cxlr_dax->dev;
>+	cxlr_dax->cxlr = cxlr;
>+	device_initialize(dev);
>+	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>+	device_set_pm_not_required(dev);
>+	dev->parent = &cxlr->dev;
>+	dev->bus = &cxl_bus_type;
>+	dev->type = &cxl_dax_region_type;
>+
>+	return cxlr_dax;
>+}
>+
>+static void cxlr_dax_unregister(void *_cxlr_dax)
>+{
>+	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
>+
>+	device_unregister(&cxlr_dax->dev);
>+}
>+
>+int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>+{
>+	struct cxl_dax_region *cxlr_dax;
>+	struct device *dev;
>+	int rc;
>+
>+	cxlr_dax = cxl_dax_region_alloc(cxlr);
>+	if (IS_ERR(cxlr_dax))
>+		return PTR_ERR(cxlr_dax);
>+
>+	dev = &cxlr_dax->dev;
>+	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>+	if (rc)
>+		goto err;
>+
>+	rc = device_add(dev);
>+	if (rc)
>+		goto err;
>+
>+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>+		dev_name(dev));
>+
>+	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>+					cxlr_dax);
>+err:
>+	put_device(dev);
>+	return rc;
>+}
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index a61805542b56..1ca5f5b02b22 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -3239,105 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
> 	return -ENXIO;
> }
>
>-static void cxl_dax_region_release(struct device *dev)
>-{
>-	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>-
>-	kfree(cxlr_dax);
>-}
>-
>-static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
>-	&cxl_base_attribute_group,
>-	NULL,
>-};
>-
>-const struct device_type cxl_dax_region_type = {
>-	.name = "cxl_dax_region",
>-	.release = cxl_dax_region_release,
>-	.groups = cxl_dax_region_attribute_groups,
>-};
>-
>-static bool is_cxl_dax_region(struct device *dev)
>-{
>-	return dev->type == &cxl_dax_region_type;
>-}
>-
>-struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>-{
>-	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
>-			  "not a cxl_dax_region device\n"))
>-		return NULL;
>-	return container_of(dev, struct cxl_dax_region, dev);
>-}
>-EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>-
>-static struct lock_class_key cxl_dax_region_key;
>-
>-static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>-{
>-	struct cxl_region_params *p = &cxlr->params;
>-	struct cxl_dax_region *cxlr_dax;
>-	struct device *dev;
>-
>-	guard(rwsem_read)(&cxl_rwsem.region);
>-	if (p->state != CXL_CONFIG_COMMIT)
>-		return ERR_PTR(-ENXIO);
>-
>-	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
>-	if (!cxlr_dax)
>-		return ERR_PTR(-ENOMEM);
>-
>-	cxlr_dax->hpa_range.start = p->res->start;
>-	cxlr_dax->hpa_range.end = p->res->end;
>-
>-	dev = &cxlr_dax->dev;
>-	cxlr_dax->cxlr = cxlr;
>-	device_initialize(dev);
>-	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>-	device_set_pm_not_required(dev);
>-	dev->parent = &cxlr->dev;
>-	dev->bus = &cxl_bus_type;
>-	dev->type = &cxl_dax_region_type;
>-
>-	return cxlr_dax;
>-}
>-
>-static void cxlr_dax_unregister(void *_cxlr_dax)
>-{
>-	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
>-
>-	device_unregister(&cxlr_dax->dev);
>-}
>-
>-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>-{
>-	struct cxl_dax_region *cxlr_dax;
>-	struct device *dev;
>-	int rc;
>-
>-	cxlr_dax = cxl_dax_region_alloc(cxlr);
>-	if (IS_ERR(cxlr_dax))
>-		return PTR_ERR(cxlr_dax);
>-
>-	dev = &cxlr_dax->dev;
>-	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>-	if (rc)
>-		goto err;
>-
>-	rc = device_add(dev);
>-	if (rc)
>-		goto err;
>-
>-	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>-		dev_name(dev));
>-
>-	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>-					cxlr_dax);
>-err:
>-	put_device(dev);
>-	return rc;
>-}
>-
> static int match_decoder_by_range(struct device *dev, const void *data)
> {
> 	const struct range *r1, *r2 = data;
>-- 
>2.52.0
>
