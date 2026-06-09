Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8F2E8B67;
	Tue,  9 Jun 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048253; cv=none; b=YlQtDEZ8qdaqSZG0DtDsRoJ5We/TM5lIB08wDIJFohGrOVD/hKfZYhGp683259FnBGMm7HSl48fMDJHfCOSY16GbYo2dl4YulKXsek8X1R+nngVe9a03j2LFy39HdiDfNTLzsmTYh6NFPwZ9sI6f6okeL4wT8qRQbPpQSE2UFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048253; c=relaxed/simple;
	bh=0HYrX9pMFcdRSqFa79JMP2BmD/OqUBWGr/loAn3y9Kc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qhfZIx72wF96KotBPoJPg4JfC3CRf45OJd+GGSdqRM0aOb4l3iLOl3iaXjAbU3CTHfnh8XALfOE9N6JmKSD1/BxOUgDScntl8x9BoKKnqgdZHbqROb1fuGtWiN2nzOXvZdoP7ydfYwuI/+PO0ZdgNG2nUB0rJPChFvSreOrx4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ9W+r7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ9W+r7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B81F00893;
	Tue,  9 Jun 2026 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048252;
	bh=XvnwJsLm3HU5xWE0HndHgKDOpsDjG1LWYDx6XHu/Hv0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mZ9W+r7ZLp1Sa0mau2kFdGvckkBVs+X7GTe4sjntmC6LmrZp6asJITGXL1ewawZcT
	 bPg/c4Ia7WqST7Sc1STG/F7Uc5SAtEkjhRxZUddHNOMAHU/UqT8KWjmJUBuDeBW5gC
	 gBUtz+tgNILGpsV21zHaiYFpNPut+38l3mN5kGsoyN/rYZ6ebmbyJLirPWCV8W92hs
	 GYxHOwMJVYCxDPsGNKQ3N6G/RhFwLtp5ujLZG0JxnQ9PE0XpcXaecdWazAPXUt3Uuz
	 hGfNd2y31p+8lVh9eZtGrXKx7QwtoqlyDnn9zKuOIzO9vOQZSc7n5HGsOw5KIG+lrI
	 /vXha2xVP5nkA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F6E4F4006A;
	Tue,  9 Jun 2026 19:37:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 19:37:31 -0400
X-ME-Sender: <xms:u6MoasPGj7E6NHXOAa3YRMFb9olfE7fjbGoonAJc7nnnbFgRwcOiYg>
    <xme:u6Moau6R02Uq0H4LnbaG4MuqjEyUGTT1n85Yye6_6mRHU7k4-DgzMKDXIAVoCrhA-
    uA6h9KqIYp8LWx49WlNJOo-u8QSGX3SrEBsBORIE5OOECmwYnSgqIk>
X-ME-Received: <xmr:u6MoapaSeh7i9_xzvzqBKJVKGnFRLYvfWCCMLAdHwE_k7iCdJer5KERWDvZigtyQZEMi4k7tjXJIIIvzaD9jyh_Di6ZAXqfWhE4>
X-ME-Proxy-Cause: dmFkZTEloCGfnJ8UpArJciky+leqkxhaYu4phRBx0B0fZ2tcsJtxcFo06AlwaYAo0RrgR3
    5G4maqYJd6UrTzg3Nic/XsjsAqsDpXV8Cx7Lad1CPjFAn8tksZCrzo3R+Z1yb2pP7tKFQL
    VmGoJvN7sYUowFVr3sHI+tFcFnPveta2H3fAPTCBY1GRvTCcYOeJpLGQq8C8OCzw+hT/bR
    1KG6zCX0GgPCfqqbIHk5CRbkrTUX4VGM7LmasXF6r/OJrkdCMeNppm4BDIZuVn2atEQ1df
    2CiULqK/jzdNxnf9b3mmGYzg4WlWm7FVY8tLneilORtQbK7asghBuMPaGFspc1iWtM1lHe
    YtCJJOdV2wtmdhPvxosi/UT+MrH2PcV5gdp1oiUCMI3t3tsucwGBCGNxUyDNHvPKDnKxoQ
    9Tu4YKERPsa14ffqbKdU3iHrR0ODGKxiu7ytCCqZ/zQFzNYAXWmVWjdV7+CI6J9l1Bnih5
    ZlryRmpsdpHAV0hxJf40QJOugcS64u8YMkgF0oyvlVHOli8O0TqyPWUiaseIwzXRZYUMDt
    y/uy3dwP+jfjGM5PDf43oMPDjJqoB7sytpk90YTMoT4gpO2QuhruBXFEVsHnjqsZSZzb20
    PRz4FeKKKTCWi+8fdk1ZNLKxTSGydoPOHjeZYDWWu+vTWco4DuctqQ/9LvAw
X-ME-Proxy: <xmx:u6MoarEG0XJsVZ9PDjWR23zgInIuQpIkx0Z13dCF6PPEaHKbge08LQ>
    <xmx:u6MoaimS7mSdkT2ojzhm0mSh26L8xQxSj17j5MpQ_7UJoMezF2_SOg>
    <xmx:u6Moaimt2Tm0xfj91cMjNCFAOWPRfTiYdkJzpCIRjvlb6MdPJfMqiQ>
    <xmx:u6MoavWvrK30p1PaA5BVeAEdn6DOVEOn7nTVuA7dmuSrNcbfELn0zQ>
    <xmx:u6Moao-gkybQKTf22jkvudIiMcRYgBX4k9zdVPNV7PUse8Cu_JvZLVu3>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:37:30 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:37:30 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>, 
 Richard Cheng <icheng@nvidia.com>, 
 dave@stgolabs.net, 
 jonathan.cameron@huawei.com, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 newtonl@nvidia.com, 
 kristinc@nvidia.com, 
 kaihengf@nvidia.com, 
 kobak@nvidia.com, 
 vaslot@nvidia.com, 
 smadhavan@nvidia.com, 
 Richard Cheng <icheng@nvidia.com>
Message-ID: <6a28a3ba2e05d_4fa7810068@djbw-dev.notmuch>
In-Reply-To: <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>
Subject: Re: [PATCH v4 0/2] Support zero-sized HDM decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dan Williams (nvidia) wrote:
[..]
> I think the way to solve this is something like below (untested).

...whoops and unset apparently.

> It keeps @hdm_end aligned with the available decoders, and tracks the
> start of zero allocations relative to their skip. I believe it may
> also address the Sashiko report.

-- >8 --
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..3f9d97c9a3b7 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -209,6 +209,14 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
+static void cxl_dpa_release_region(struct resource *parent, struct resource *res)
+{
+	/* zero sized decoders are not tracked in tree */
+	if (resource_size(res) == 0)
+		kfree(res);
+	__release_region(parent, res->start, resource_size(res));
+}
+
 /* See request_skip() kernel-doc */
 static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
 				     const resource_size_t skip_base,
@@ -256,7 +264,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
-	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
+	cxl_dpa_release_region(&cxlds->dpa_res, res);
 	if (cxled->skip)
 		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
@@ -336,6 +344,22 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
+static struct resource *cxl_dpa_request_region(struct resource *parent,
+					       resource_size_t start,
+					       resource_size_t n,
+					       const char *name)
+{
+	if (!n) {
+		struct resource *res = kmalloc_obj(*res);
+
+		if (!res)
+			return NULL;
+		*res = DEFINE_RES_NAMED(start, n, name, 0);
+		return res;
+	}
+	return __request_region(parent, start, n, name, 0);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -349,12 +373,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
-	if (!len) {
-		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
-			 port->id, cxled->cxld.id);
-		return -EINVAL;
-	}
-
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
 			port->id, cxled->cxld.id, cxled->dpa_res);
@@ -378,8 +396,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		if (rc)
 			return rc;
 	}
-	res = __request_region(&cxlds->dpa_res, base, len,
-			       dev_name(&cxled->cxld.dev), 0);
+	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
+				     dev_name(&cxled->cxld.dev));
 	if (!res) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
@@ -545,7 +563,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct device *dev = &cxled->cxld.dev;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	if (!cxled->dpa_res)
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..6f4d634b2cfb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1433,6 +1433,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!len)
+		return 0;
+
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..0d03e3bedb40 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2090,7 +2090,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (!cxled->dpa_res) {
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
