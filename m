Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526159;
	b=k2bmN47wZKfLwksy92ApebuBXsFyWo11bMKsy8EqocEFR2ivoGkgcA+G2YEzErsU2ppW
	 4rbNbc2C6brW2/TbNKTcmAQ8KFQY48JaeNfm50RKnNx7PmUCbP5Q9yHnN0KrpjqVytUZ8
	 pdcwHIvJrclB/T3zoIlI/96vzy8XOCvooXnDfdQ3w9fij5+0KdK6id8IOMDiFCsWgf5ED
	 4YTEoZTn1WtavVzZ7vU34vvrpvIhEMWhTu2icZOeE3edBmU3ORmsGdkayf5zBi47olMME
	 5jUeL9vaM00VGU/P4grFuvy8VQcEMOLeODW7PtAwiy4CL2KSZXkV1ugE+Vu6FN8IVhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526159;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Desert-Gusty:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=8sd+b5bR7hKdNZR0sXMGAFb1B9DZaeO+KmzbylTg4nQ=;
	b=Vs/COdI7S77C+5G5S+Ycl98gyg/Uj0OXs0ECmkq6qePLVfVDCo0D0Z0YFJjwqr8d16ST
	 HiDH37Y4hn0F/B/qYuDwNacAbPptme97sbPL/DgTrwGj9ysrnQyIhSOjhvVonbFpxLOn8
	 8oFbgtTAfr0RD7ByDpoxh8/nXYL7Ume6EwR8cm0zNZmML53yynxdG9z4IWCNKgzfKPGDS
	 5jlsC+yGPa46eL0TL+yo9g9kiOzByRDnyAC6zT1ITL3eoubU7yKt83duuAlok+humIB/b
	 rKJFA/cEVnr5LW5aup5gL9YnmiC4JI3cTbry8h4l6wcTJXapGMuoFNvKzr2e/keaEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=W6YRFrC4;
	arc=none smtp.remote-ip=23.83.218.252
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D6606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 19:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45D6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=W6YRFrC4
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7E853722723;
	Tue, 20 Oct 2026 19:55:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (100-96-2-229.trex-nlb.outbound.svc.cluster.local [100.96.2.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2C3D7722650;
	Tue, 20 Oct 2026 19:55:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Gusty: 268982b2502f6776_1792526152324_3039649911
X-MC-Loop-Signature: 1792526152324:3277151387
X-MC-Ingress-Time: 1792526152324
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.2.229 (trex/8.0.2);
	Tue, 20 Oct 2026 19:55:52 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4j8NSl3XN2z2l;
	Tue, 20 Oct 2026 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792526152;
	bh=8sd+b5bR7hKdNZR0sXMGAFb1B9DZaeO+KmzbylTg4nQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=W6YRFrC4h37INMqkqWMDlXpVVOLBDhTWLBLBYtiak0oglcviL15khTtJgNatKx1Y2
	 f1RRIoIZVOY9J4/80RjphOP3pklzO/YAYtEZbY7FRvU3bJ6LP7FtFkap3wUqbYClwu
	 vJVgFoUrgf0MkZupeCGsm6kIt8g6E6ZjqhPbdr3orI89g2OaekU/7VXxvm3Zr+8qw1
	 OMlfrynbn4/K9rYB09VAuwT8FOEjIVGPT1waAYIOC5on/NlcuK31U/aL3/dFHzNEvL
	 gIraohH4xEEnJtbnYcellocLxwc1EGW/5cA5rrb+hQdYKN+hYEv3YydKQ/co5EZh52
	 FVECc7iPPwdwA==
Date: Tue, 20 Oct 2026 12:55:47 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 04/10] cxl: Add HDM-DB region creation
Message-ID: <20261020175606.eeeiuszbclq55uwg@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 22 Sep 2026, Davidlohr Bueso wrote:

> static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> {
>+	bool bi = cxld->target_type == CXL_DECODER_DEVMEM &&
>+		  cxld->region && cxl_root_decoder_is_bi(cxld->region->cxlrd);
>+
> 	u32p_replace_bits(ctrl,
> 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>+	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);

For the record, this should be conditional:

+       /* BI is reserved unless the component is BI capable */
+       if (bi || FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, *ctrl))
+               u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);

>+
>+	if (bi && is_endpoint_decoder(&cxld->dev)) {
>+		struct cxl_endpoint_decoder *cxled =
>+			to_cxl_endpoint_decoder(&cxld->dev);
>+
>+		u32p_replace_bits(ctrl, cxled->pos,
>+				  CXL_HDM_DECODER0_CTRL_ISP_MASK);
>+	}
> }
