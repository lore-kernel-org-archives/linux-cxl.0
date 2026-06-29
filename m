Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C133EB06
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756765; cv=none; b=A3Xgec9wKKJOoyr6om1Ah+c6h5pMfCfTwUsM727zDI/Q4jiS2TUl2ewyVDOjJQlWPeBmCbZ/r9S0YbVZ2XWGzlt36Q5wk+MhQhkEynwxGLDvg3XcRSraTbpdjXUpIQObwllOMplFUuHTtphMr6K2S55ebcRljGSgu/1HmgQWn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756765; c=relaxed/simple;
	bh=bETxppE7r2zaDQBmNRICozZJzwQhrE9wCcmGlg6Qckw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM4UWB+96LUp2TJjyMeCKIZZEWJ7wO0SE5ijnSkow3/pde/FbEUX8hHyS33iZKYgYqH6yh4V3KXVwChBtasqb7oCq0O01YiC+9JSdHsfVGlpXXxwK8ZEtbCZEYCqaIna0Bo0b/BuBSylfJ2VPiNN38m3YGyFGzD6Wur6Lvb8yMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ClG7FqVg; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ClG7FqVg"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 230DD943086;
	Mon, 29 Jun 2026 14:44:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.98.255.9])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 982BA9435C2;
	Mon, 29 Jun 2026 14:44:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Cure: 7f473c85584cb72d_1782744250019_321482182
X-MC-Loop-Signature: 1782744250019:3095423882
X-MC-Ingress-Time: 1782744250018
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.255.9 (trex/7.1.5);
	Mon, 29 Jun 2026 14:44:10 +0000
Received: from offworld (181-161-142-22.fo.baf.movistar.cl [181.161.142.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4gppvD3thFz105D;
	Mon, 29 Jun 2026 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1782744249;
	bh=92OdsPY/wMiJiP7SJGn/dV/PeVTcGI8OzmVFRfTqX/s=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ClG7FqVghwvjhI1QriwIGLoA7czLtSWsxcLoNqOS0gjIbmAaZQXQhhZdoTfdes8zK
	 PvxYTaxdI+3JISo6mTs9ZRSkz2Rm2JUrn9e+ZbdntuKUh5VGn9AogdDGdceglaXcXZ
	 E7UwBk/OzN8QCgEhX0/tIt0CnQTX0hWjoJJL8QdQnpOq1G481loW//rCR8evKFLFNs
	 rhP/HHEb/crtm60wyQddcs3ZYvKumgex91xDTAIzfoLo8JaXt3A/L6O7cWPftc9Z0x
	 9zOEIuukPy3NX3O/Mw+MF/bs+SRNYB1P/pNRCtVisZ34r5Emt/M8Hmt8Qa9XMbHL25
	 gxleVjSezD2+g==
Date: Mon, 29 Jun 2026 07:44:03 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/5] cxl: Add BI register probing and port
 initialization
Message-ID: <20260629144403.wuwhbqpfimdg524a@offworld>
References: <20260615145529.13848-2-dave@stgolabs.net>
 <20260615173541.BE49D1F000E9@smtp.kernel.org>
 <ajo8nZVglGsutdpg@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajo8nZVglGsutdpg@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 23 Jun 2026, Richard Cheng wrote:

>On Mon, Jun 15, 2026 at 05:35:41PM +0800, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] devm mappings for dport BI registers leak on hotplug due to being called outside the dport devres group in cxl_port_add_dport.
>> --
>>
>> commit a836080fdf13fa334055f7f13a95491b66ef793f
>> Author: Davidlohr Bueso <dave@stgolabs.net>
>>
>> cxl: Add BI register probing and port initialization
>>
>> This commit adds register probing for BI Route Table and BI Decoder capability
>> structures. It introduces helpers to map the BI Decoder of a downstream port
>> at dport-creation time and a port's own BI capability during port probe.
>>
>> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> > index ada51948d52fa..ca8d8c14b7876 100644
>> > --- a/drivers/cxl/port.c
>> > +++ b/drivers/cxl/port.c
>>
>> [ ... ]
>>
>> > @@ -261,6 +321,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>> >  	/* This group was only needed for early exit above */
>> >  	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
>> >
>> > +	if (dev_is_pci(dport_dev)) {
>> > +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
>> > +		case PCI_EXP_TYPE_ROOT_PORT:
>> > +		case PCI_EXP_TYPE_DOWNSTREAM:
>> > +			cxl_dport_map_bi(dport);
>>
>> [Severity: High]
>> Does this leak devm mappings if the dport is hot-removed?
>>
>> Looking at cxl_port_add_dport(), devm_cxl_add_dport_by_dev() creates a
>> devres group for the dport on the parent port's device. However,
>> cxl_dport_map_bi() is called after devm_cxl_add_dport_by_dev() returns,
>> meaning the devres group has already been closed.
>>
>> Because cxl_dport_map_bi() calls devm_cxl_iomap_block() against the parent
>> port device, these devm allocations bypass the dport group and attach
>> directly to the parent port device.
>>
>> If the dport is hot-removed, the dport devres group is released, but the BI
>> capability mappings appear to be left behind. If the dport is subsequently
>> re-added, won't devm_request_mem_region() fail with -EBUSY due to the
>> physical address region conflict, permanently breaking BI capabilities?
>>
>
>Hi Davidlohr,
>
>I think sashiko-bot's is right on this part, this part runs after devm_cxl_add_dport_by_dev()
>has already closed the dport's devres group, so the BI request_mem_region()/ioremap() land on
>the port's devres list outside that group. On runtime dport removal the group release won't free
>them, and re-adding the dport then fails the BI region request with -EBUSY.
>
>The dport RAS mapping is done inside __devm_cxl_add_dport() while the group is still open for
>this reason.
>I would suggest mapping BI the same way which is to move cxl_dport_map_bi() into __devm_cxl_add_dport()
>next to the RAS setup, and set map->host like RAS does.

I went with this adding a new devm_cxl_dport_bi_setup() helper and calling it from
__devm_cxl_add_dport():

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cdb741d09b9e..5511a8b33062 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -929,6 +929,44 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
  	return ctx.count;
  }
  
+static void cxl_dport_map_bi(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.bi_decoder.valid) {
+		dev_dbg(dev, "BI Decoder registers not found\n");
+		return;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
+		dev_dbg(dev, "Failed to map BI Decoder capability\n");
+}
+
+/**
+ * devm_cxl_dport_bi_setup - Map BI Decoder registers on a CXL dport
+ * @dport: the cxl_dport that needs to be initialized
+ *
+ * Must be called while the dport's devres group is open so iomap
+ * allocations are released on dport removal.
+ */
+void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
+{
+	if (!dev_is_pci(dport->dport_dev))
+		return;
+
+	switch (pci_pcie_type(to_pci_dev(dport->dport_dev))) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		dport->reg_map.host = dport_to_host(dport);
+		cxl_dport_map_bi(dport);
+		break;
+	default:
+		break;
+	}
+}
+
  /*
   * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
   * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 63005cf0fa91..74bbc195d624 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1264,8 +1264,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  
  	cxl_debugfs_create_dport_dir(dport);
  
-	if (!dport->rch)
+	if (!dport->rch) {
  		devm_cxl_dport_ras_setup(dport);
+		devm_cxl_dport_bi_setup(dport);
+	}
  
  	/* keep the group, and mark the end of devm actions */
  	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));

Thanks,
Davidlohr
