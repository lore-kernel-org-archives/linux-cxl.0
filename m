Received: from frog.ash.relay.mailchannels.net (frog.ash.relay.mailchannels.net [23.83.222.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC485632A9
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979661; cv=none; b=GppvdRzLhYnASvzpkg0yDxCMy0b3JqXvudiBMZYLrzfaHeNP91tRWFpJJx+zzpMPFawsswmzwaL+MJ21wt7dpXgBTggKc6ZWGY2EsVKCOcosnJWfGFWQ9nZhh6W6R+hu1CoJTNZd+AUFdZsMQtFu16E3/tgj7tC5AfBbzI7+QsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979661; c=relaxed/simple;
	bh=zMg76Jq2teOkGQU87CNwWrkBYsmFbOBY8TOCg4IPYLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXtQRKEPxRX5zoaEDVRXOaBxr+lOJbA0fWHO6W1xpF0MCDIfISFY4AQG21Jc21ykchJ9+7Lu0Jf+Nu1SMapx3XO6ZfvG0wzUukVtcMynXMItmkxd4J2zGklmxIF5kAGcq82uIByt1UaYuKTsVmTBm1rn4CBRgd2UX/EH0ebBXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=RLIQ43zF; arc=none smtp.client-ip=23.83.222.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="RLIQ43zF"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 28831462C3E;
	Wed, 09 Sep 2026 18:47:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (100-96-173-63.trex-nlb.outbound.svc.cluster.local [100.96.173.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E5C87462D42;
	Wed, 09 Sep 2026 18:47:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Wide-Eyed: 6a610e96144d8e99_1788979652033_873849719
X-MC-Loop-Signature: 1788979652033:3526234840
X-MC-Ingress-Time: 1788979652032
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.63 (trex/8.0.2);
	Wed, 09 Sep 2026 18:47:32 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4hg8tq1kq2z103q;
	Wed,  9 Sep 2026 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788979651;
	bh=+/ZXZ2otNHYvqQgbIUv5YqEJ+829Y5kmVZrPpHYi9Hk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=RLIQ43zFRvKzmZelqvkZ05kDhyWOD6qPbcLmybchVZawAGVAI4Qe2aHv+/yC8z6S3
	 LltcWOaP+33tZFisu8l/e1eb0pa+mRJWI7zRR8wcbhvzqnmpUND29j8Zunmu6XKVOc
	 iiyJVYZGswdPn74y1UCtIyI5bzrCNOnBR83IVeC5OPiQPrSmT07fJRntlb2H6uy35z
	 wZhcaE78p9f9ZEm2v0dQknd5B5aUidXXk5jakGaPL+7FZ8/GssAP+t7Kof4FlzNhLk
	 AT2XuAjdrkVi1aQRD4AKaxVZnseyisRgxvgIlRtvBPj+6fQpbBEpvYcwVD4SwOROzS
	 +MdLXOotIzsBw==
Date: Wed, 9 Sep 2026 11:47:28 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 0/10] cxl: Support Back-Invalidate
Message-ID: <20260909184728.mznbg6ox6nqnvv5p@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Wed, 09 Sep 2026, Davidlohr Bueso wrote:

>An auto-committed BI decoder found during enumeration is adopted when
>the device and its path are BI capable, and only broken combinations
>are refused (patches 7-8). See the auto-discovery tests section below.

And for anyone curious, this is being tested in qemu with the below.

-------8<--------------------------
[PATCH] cxl/region: Assemble committed regions through passthrough decoders

Auto-assembly of committed decoders (BIOS-committed state, or a
kexec inheriting the previous kernel's regions) fails whenever the
path crosses a port with a passthrough decoder. Such ports publish
no HDM decoder capability (single dport host-bridges per 8.2.5.12),
so their decoder's range, interleave settings and target list only
ever existed as software state in the kernel that created the
region; nothing survives to re-enumerate, and every auto-assembly
step that validates committed state rejects the hop:

   pcieport 0000:0d:00.0: failed to find decoder mapping 0x190000000-0x19fffffff
   cxl region0: region sort failed
   cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

A passthrough hop is decode-transparent, so treat it in the auto
flows the way the manual flow already does - program the software
state rather than validate it:

  - find_pos_and_ways(): position through a passthrough hop is
    unambiguously pos 0 of 1 ways.
  - match_auto_decoder(): the passthrough decoder is a valid pick
    despite carrying no committed range.
  - cxl_port_setup_targets(): fall through to programming the decoder
    (iw/ig/hpa_range, and the target entry) instead of comparing
    against state that cannot exist.

Not-Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
  1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a9dcaff47a72..da83700f81ca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -946,6 +946,18 @@ static bool spa_maps_hpa(const struct cxl_region_params *p,
  		p->res->end == range->end;
  }
  
+/*
+ * No HDM decoder capability published (single dport host-bridges per
+ * 8.2.5.12): decode is passthrough via the sole dport and the port's
+ * decoder carries no hardware state to re-enumerate or validate.
+ */
+static bool is_passthrough_port(struct cxl_port *port)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	return port->nr_dports == 1 && cxlhdm && !cxlhdm->regs.hdm_decoder;
+}
+
  static int match_auto_decoder(struct device *dev, const void *data)
  {
  	const struct cxl_region_params *p = data;
@@ -961,6 +973,10 @@ static int match_auto_decoder(struct device *dev, const void *data)
  	if (spa_maps_hpa(p, r))
  		return 1;
  
+	/* a passthrough decoder has no committed range to match */
+	if (is_passthrough_port(to_cxl_port(dev->parent)))
+		return 1;
+
  	return 0;
  }
  
@@ -1583,7 +1599,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
  		return -ENXIO;
  	}
  
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
+	    !is_passthrough_port(port)) {
  		if (cxld->interleave_ways != iw ||
  		    (iw > 1 && cxld->interleave_granularity != ig) ||
  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
@@ -1628,7 +1645,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
  		return -ENXIO;
  	}
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
+	    !is_passthrough_port(port)) {
  		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
  			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
  				dev_name(port->uport_dev), dev_name(&port->dev),
@@ -1956,6 +1974,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  	struct device *dev __free(put_device) =
  		device_find_child(&parent->dev, range, match_switch_decoder_by_range);
  	if (!dev) {
+		/*
+		 * A passthrough hop is decode-transparent: its decoder
+		 * carries no committed range to re-enumerate, but the
+		 * position through it is unambiguous.
+		 */
+		if (is_passthrough_port(parent)) {
+			*pos = 0;
+			*ways = 1;
+			return 0;
+		}
  		dev_err(port->uport_dev,
  			"failed to find decoder mapping %#llx-%#llx\n",
  			range->start, range->end);
-- 
2.39.5

