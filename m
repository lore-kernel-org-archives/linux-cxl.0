Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6183019D9
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504506; cv=none; b=gQGgCRLhyTgSBb0KiTOsc64ZFtQfgtmyBJb1Mtw4RLt5ttI5PHpxyf1R9NzosKCaJRMwh9DqunJEzoPsHZYoJ2LVBx9R8l/EwABckjkEJVLxeWg2PzT1oeLukHiPAtrwmy/p55Ijw1Ph0vuu0nMtQOx0r978K67tVIgJv4GLuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504506; c=relaxed/simple;
	bh=7ZJ29Yxo7mQVtfq9yv3t/6tawU0oK1TdWteIKMLzq1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEHEcCd2mgnr+MMwTR3Po3j+Huj1RK1ee5y8STrsm3VSBgnoqlYZIVjnS8OObJ2L/Vp6KecXFR6eghdsTJaI8EeRrWlvAKvmmZd802vLF+TbPHCN8ITv7B+I1zJintCvsvAnNAAJZl8v/tRxKPm0a+0YnfS9Si5klTb4/BrMer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BZAQdFNk; arc=none smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BZAQdFNk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E88B42843;
	Tue, 15 Sep 2026 20:17:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-100-63-247.trex-nlb.outbound.svc.cluster.local [100.100.63.247])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 04FBF42E63;
	Tue, 15 Sep 2026 20:17:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Left: 579bfdc632ffb278_1789503429292_2489944977
X-MC-Loop-Signature: 1789503429292:824320677
X-MC-Ingress-Time: 1789503429292
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.63.247 (trex/8.0.2);
	Tue, 15 Sep 2026 20:17:09 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4hktbS2QXQzymb;
	Tue, 15 Sep 2026 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789503428;
	bh=hHYEmL+byxJpsBwFEygrkZO8C2/K986qKEZhYeybOCo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BZAQdFNkgW8GyfRSc5/jhU22Kvg5EUFhrkoAi1ofGdp6dnuNae/ja3mls3i5F3M6b
	 N7Tze+GN8Niy4bTWPf/F8wUp6SwElk9wGnRMw2vyKoRJtJcKrIMCAU03WFyMUWMiaW
	 qGhzk4p1MHpSm2YGcDqYu0nBNstY5Q5xG91IDyEEMe71km6dvvHPccjaQBuO5lt+zr
	 f0cY6lSG+wqaO8qbcXV65s6/olejateVPuzgeBvrbvR/sH/EuLMCKdjIuRX64lZpQJ
	 Q2OF0nIJvcUO9dhthoZF4H4/HehdXT2cV0NcyRllKbga4MHlD+4E8i66aSld/7Ny3+
	 FV8C7RgfYibqQ==
Date: Tue, 15 Sep 2026 13:17:05 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	icheng@nvidia.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20260915201705.euqusiybd6vxy5of@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-3-dave@stgolabs.net>
 <7501f4d8-2241-4bf6-8eb7-ca94318b08f4@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7501f4d8-2241-4bf6-8eb7-ca94318b08f4@zohomail.com>
User-Agent: NeoMutt/20220429

On Thu, 10 Sep 2026, Li Ming wrote:

>>+static int cxl_bi_commit_dport(struct cxl_dport *dport)
>>+{
>>+	struct cxl_port *port = dport->port;
>>+	int rc;
>>+
>>+	if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
>>+	    PCI_EXP_TYPE_DOWNSTREAM)
>>+		return 0;
>Missing check to confirm if the dport is a PCI_EXP_TYPE_ROOT_PORT 
>here? I think the function is still used for rp.

So root ports call into this function yes, but they do not get past
this check which filters them out - root ports do not do commit
(Table 8-156), but I will add a comment.

>>+
>>+	rc = __cxl_bi_commit_decoder(dport->dport_dev, dport->regs.bi_decoder);
>>+	if (!rc && port->regs.bi_rt)
>>+		rc = __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
>Maybe check whether port->dev is PCI_EXP_TYPE_UPSTREAM before calling 
>__cxl_bi_commit_rt()?

The check would have to be on port->uport_dev but I think it is safe
as is.

At this point we know its a switch DSP, and a DSP is only ever added to the
switch's USP port. So port is the switch USP whenever the route table
commit is reachable.

>>+
>>+	return rc;
>>+}
>>+

[...]

>>+void cxl_bi_reset_detected(struct cxl_port *endpoint)
>>+{
>>+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>>+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>+	void __iomem *bi = endpoint->regs.bi_decoder;
>>+
>>+	if (!cxlds->bi)
>>+		return;
>>+
>>+	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
>>+		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
>>+		return;
>>+
>>+	dev_dbg(cxlds->dev, "BI disabled by reset\n");
>I guess it would impact the regions using BI, maybe it is worth a 
>dev_warn()?

Sure.

>>+	cxlds->bi = false;
>>+}
>>+EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
>>+
>>+int cxl_bi_setup(struct cxl_port *endpoint)
>>+{
>>+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>>+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>+	struct cxl_dport *dport = endpoint->parent_dport;
>>+	struct cxl_dport *dport_iter;
>>+	struct cxl_port *port_iter;
>>+	int rc;
>>+
>>+	if (!dev_is_pci(cxlds->dev))
>>+		return 0;
>>+
>>+	/* BI is VH-only */
>>+	if (cxlds->rcd)
>>+		return 0;
>>+
>>+	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
>>+			       endpoint->regs.bi_decoder))
>>+		return 0;
>>+
>>+	/* walkup the topology twice, first to check, then to enable */
>>+	port_iter = dport->port;
>>+	dport_iter = dport;
>>+	while (!is_cxl_root(port_iter)) {
>>+		/* check rp, dsp */
>>+		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
>>+				       dport_iter->regs.bi_decoder)) {
>>+			dev_dbg(cxlds->dev, "BI not supported by topology\n");
>>+			return 0;
>>+		}
>>+
>>+		/* check usp */
>>+		if (dev_is_pci(port_iter->uport_dev) &&
>>+		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
>>+			    PCI_EXP_TYPE_UPSTREAM) {
>>+			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
>>+					       port_iter->regs.bi_rt)) {
>For the switch upstream port, the bi pointer will not be checked in 
>cxl_is_bi_capable(), maybe pass a NULL instead of 
>port_iter->regs.bi_rt for cxl_is_bi_capable()?

Done.

Thanks,
Davidlohr
