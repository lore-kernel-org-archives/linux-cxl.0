Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAD37DE8B
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995011; cv=none; b=aOPllQqGfwn2a9V40ftdPyfm8O6s4Q57es4V836ukg0zzVqKEUZJGEK8L/jUmUcAB8qghMtoqY5CZKrP+5j9PY4TvGuaEekEAlNYOVLr8rNhlf8BsiDk/DQbakSjtLnOts3VkI4lV2lB4Xh6A4dhf1wIYTT4MTdrh9U0YH/+frM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995011; c=relaxed/simple;
	bh=aYCBu/AQ+a4I/3Q4kkYKyCAFSQ8/vVYTkBVaUG/fb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWHLfvib79ZpIzcuyDs+iz5GHJyGq8lXyBXz6YJPqcmcvoeFsmqXdrLYvKg1cvGeluSQ68jX/zQ30mkjxjxG9APfZBdZjcNjjXGSBDvv0S8bVLPdpuppxftXGXkwSNE7BvssBm9hmULGpw2MUSlF3BzPyX5x5rDesoSjXB2L8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WRbmL1H4; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WRbmL1H4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 83B6E8015C3;
	Tue, 14 Jul 2026 02:01:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a260.dreamhost.com (100-104-243-177.trex-nlb.outbound.svc.cluster.local [100.104.243.177])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C65768006BE;
	Tue, 14 Jul 2026 02:01:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Bubble: 0a5ec2aa60551679_1783994482382_2500815278
X-MC-Loop-Signature: 1783994482382:378648659
X-MC-Ingress-Time: 1783994482382
Received: from pdx1-sub0-mail-a260.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.243.177 (trex/8.0.2);
	Tue, 14 Jul 2026 02:01:22 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a260.dreamhost.com (Postfix) with ESMTPSA id 4gzjG735g8z105B;
	Mon, 13 Jul 2026 19:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783994479;
	bh=kWHQnb0EGGzHVURtBrlXhWPoc3UwUKt9uP8bMtaV14o=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WRbmL1H4tIfIB+sLtnY2usunnpEphEfwfIP/bha4btsJglz25Om7vGnjUjyFHcJE8
	 1UUIsyZpBsTyxmaAKAOytdX23mDX/vrjyy3dBJsDuL/dHNciMbbf2etubEM7ziNgIP
	 kY8h4Mpv2cwHpohOjlwn85bQ560l55l+Tueg1BR6tShtLvSNdkJ+K/ZIkO8dq0cfdb
	 RsmaQSKD/QAcDJvbCVJxy/8XDiST7SHIvTKJI2eBhdkmUGtc2JmDtvpLqVkHvxa3G+
	 JZFSGBSZwVp/PMS9M7KyGc6RyLg/RtN4LKDmVNxfNPNAYVTGI9nog8cWTKxHT9OlPp
	 EhIQR5LMJ2Nyg==
Date: Mon, 13 Jul 2026 19:01:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260714020116.gehv2wfqrlecu5bc@offworld>
References: <20260615145529.13848-3-dave@stgolabs.net>
 <20260615173429.0CBB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615173429.0CBB61F000E9@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Mon, 15 Jun 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>- [High] Mixing `goto` error handling with `__free()` scope-based cleanup declarations.

Trivial, fixed for v6. See below.

>- [High] Missing explicit commit for the Endpoint BI Decoder Control Register.

False positive, this commit does not apply to endpoints.

>- [High] Root port BI enablement logic is unreachable and contradicts the commit message.

False positive.

Sashiko read !is_cxl_root(port_iter) as "the RP is skipped," but the RP sits a
level below the platform root.

>- [High] Missing reference counting (`nr_bi`) for shared downstream ports in cascaded switch topologies.

I am avoiding cascaded switch topologies (PBR/HBR), nor does this touch at all wrt
BI in the latest spec.

See: https://lore.kernel.org/all/20260608000226.jb2ploxc5nkjestk@offworld/

>--
>
>commit 31994c2bf9d14374bacdb07d505a19b18a761e35
>Author: Davidlohr Bueso <dave@stgolabs.net>
>
>cxl/pci: Add BI topology enable/disable
>
>This commit implements cxl_bi_setup() to walk the CXL port topology and enable
>BI flows on the device and every component in the path. It also implements a
>teardown counterpart, cxl_bi_dealloc().
>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index d1f487b3d809a..b1b0f3eab90e8 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>
>[ ... ]
>
>> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
>> +	void __iomem *bi = dport->regs.bi_decoder;
>> +	struct cxl_port *port = dport->port;
>> +	u32 ctrl, value;
>> +	int rc;
>
>[ ... ]
>
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +		if (enable) {
>> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> +				return 0;
>> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> +		}
>
>[Severity: High]
>In cascaded switch topologies, can this unconditionally clear the
>CXL_BI_DECODER_CTRL_BI_ENABLE bit while other endpoints below the switch
>are still actively using it?
>
>Unlike the root port case which uses dport->nr_bi for reference counting,
>downstream ports appear to clear this bit as soon as the first endpoint
>unbinds. This might break BI routing for other active endpoints on a shared
>downstream port.
>
>Does this need reference counting similar to the root port?
>
>[ ... ]
>
>> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>> +{
>
>[ ... ]
>
>> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +	cxlds->bi = enable;
>> +
>> +	dev_dbg(cxlds->dev, "BI requests %s\n",
>> +		str_enabled_disabled(enable));
>> +
>> +	return 0;
>> +}
>
>[Severity: High]
>Is this missing an explicit commit for the Endpoint BI Decoder Control
>Register?
>
>The CXL 4.0 specification requires an explicit commit after changing
>BI_ENABLE for any BI Decoder via CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ.
>
>While __cxl_bi_ctrl_dport() correctly calls __cxl_bi_commit_decoder() after
>updating the downstream ports, __cxl_bi_ctrl_endpoint() omits this step.
>
>Could this cause the endpoint device to ignore the BI enablement state and
>silently fail to enable BI flows?
>
>[ ... ]
>
>> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	struct cxl_dport *dport_iter, *dport, *failed;
>> +	struct cxl_port *port_iter;
>> +	struct pci_dev *pdev;
>> +	int rc;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return 0;
>> +
>> +	pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +
>> +	if (!port)
>> +		return -EINVAL;
>
>[ ... ]
>
>> +	port_iter = port;
>> +	dport_iter = dport;
>> +	while (!is_cxl_root(port_iter)) {
>> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
>> +		if (rc)
>> +			goto err_rollback;
>
>[Severity: High]
>The commit message states this will write BI Enable on each dport's BI
>Decoder Control register. However, doesn't this loop terminate before
>processing the root port?
>
>Since the loop condition is !is_cxl_root(port_iter), when port_iter reaches
>the CXL root, the loop exits and skips configuring the root port entirely.
>
>Additionally, if the loop did reach the PCI_EXP_TYPE_ROOT_PORT code inside
>__cxl_bi_ctrl_dport(), that code actually clears the enable bit:
>
>__cxl_bi_ctrl_dport() {
>    ...
>    case PCI_EXP_TYPE_ROOT_PORT:
>        ...
>        value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>}
>
>Should this loop include the root port, and should the root port logic actually
>set the enable bit rather than clearing it?
>
>[ ... ]
>
>> +	/* finally, enable BI on the device */
>> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
>> +	if (rc)
>> +		goto err_rollback;
>> +
>> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
>> +					cxl_bi_dealloc, cxlds);
>> +
>> +err_rollback:
>> +	/*
>> +	 * Undo all dports enabled so far, including the failed one.
>> +	 */
>> +	failed = dport_iter;
>> +	dport_iter = dport;
>> +	port_iter = port;
>> +	while (!is_cxl_root(port_iter)) {
>> +		cxl_bi_ctrl_dport_disable(dport_iter);
>> +		if (dport_iter == failed)
>> +			break;
>> +		dport_iter = port_iter->parent_dport;
>> +		port_iter = dport_iter->port;
>> +	}
>> +	return rc;
>> +}
>
>[Severity: High]
>Is it safe to mix goto-based error handling with scope-based cleanup in
>this function?
>
>This function declares struct cxl_port *port __free(put_cxl_port) at the
>top, but also uses a goto err_rollback pattern for failure paths.
>
>Mixing goto labels with __free() declarations in the same function creates
>confusing ownership semantics and violates subsystem cleanup guidelines.
>
>Should this be fully converted to scope-based cleanup, or avoid using
>__free() here?

Sure. I went with this this change/unwind consolidation, fyi:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ed54268e9ec7..dc700f7c75c0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1247,10 +1247,52 @@ static void cxl_bi_dealloc(void *data)
  	}
  }
  
+/*
+ * Enable BI on every dport in the path, then on the device itself.
+ * On failure, unwind only the dports that fully enabled.
+ */
+static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
+			      struct cxl_port *port, struct cxl_dport *dport)
+{
+	struct cxl_dport *dport_iter, *failed;
+	struct cxl_port *port_iter;
+	int rc;
+
+	port_iter = port;
+	dport_iter = dport;
+	while (!is_cxl_root(port_iter)) {
+		rc = cxl_bi_ctrl_dport_enable(dport_iter);
+		if (rc)
+			goto err_rollback;
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	/* finally, enable BI on the device */
+	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
+	if (rc)
+		goto err_rollback;
+
+	return 0;
+
+err_rollback:
+	/* Undo dports that fully enabled; skip the failed one. */
+	failed = dport_iter;
+	dport_iter = dport;
+	port_iter = port;
+	while (!is_cxl_root(port_iter) && dport_iter != failed) {
+		cxl_bi_ctrl_dport_disable(dport_iter);
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+	return rc;
+}
+
  int cxl_bi_setup(struct cxl_dev_state *cxlds)
  {
  	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
-	struct cxl_dport *dport_iter, *dport, *failed;
+	struct cxl_dport *dport_iter, *dport;
  	struct cxl_port *port_iter;
  	struct pci_dev *pdev;
  	int rc;
@@ -1293,35 +1335,11 @@ int cxl_bi_setup(struct cxl_dev_state *cxlds)
  		port_iter = dport_iter->port;
  	}
  
-	port_iter = port;
-	dport_iter = dport;
-	while (!is_cxl_root(port_iter)) {
-		rc = cxl_bi_ctrl_dport_enable(dport_iter);
-		if (rc)
-			goto err_rollback;
-
-		dport_iter = port_iter->parent_dport;
-		port_iter = dport_iter->port;
-	}
-
-	/* finally, enable BI on the device */
-	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
+	rc = cxl_bi_enable_path(cxlds, port, dport);
  	if (rc)
-		goto err_rollback;
+		return rc;
  
  	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
  					cxl_bi_dealloc, cxlds);
-
-err_rollback:
-	/* Undo dports that fully enabled; skip the failed one. */
-	failed = dport_iter;
-	dport_iter = dport;
-	port_iter = port;
-	while (!is_cxl_root(port_iter) && dport_iter != failed) {
-		cxl_bi_ctrl_dport_disable(dport_iter);
-		dport_iter = port_iter->parent_dport;
-		port_iter = dport_iter->port;
-	}
-	return rc;
  }
  EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
