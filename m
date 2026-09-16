Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329E4A9D42
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602330; cv=none; b=X6Js8m/h5YrKd4/2Pn7pgkZMUO1tUuJmcTMA+7c8ZAhogA5x0S10SR0v34eJd8AucsNQexKvV31T8JKFSs0arXRkbvV0cNpSIilgjXy+mZUtx1+nkXHTcsFu68Lcz2ntMeQ1FXpFaRIpO/LMjGGfaVGw45OPia1wlwC4Fy/rTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602330; c=relaxed/simple;
	bh=qjQfO8GVzBSS8SA+AVRJ+QFdgtk8iKjh31od1SIk+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1RBDaLQOdPU6XkF8xr1NTCVdP9d6EyEmxjIUTDhb6X3YYp9trGHN4b1e5+UHBGlaIbdH8TameLsbfOUOOYlORBs5ZeOpsv/YENWfus8J++xyfjXjUTAnFvZ8QEoqFZY11WyXrR64MFhM98QAuFIuqRJ5PRfClCbhU+JtbBieFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bmPyZ52G; arc=none smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bmPyZ52G"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C8C95160679;
	Wed, 16 Sep 2026 23:27:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-100-63-247.trex-nlb.outbound.svc.cluster.local [100.100.63.247])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7119F161AF6;
	Wed, 16 Sep 2026 23:27:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Well-Made: 6962876b70e8d844_1789601258680_2361391356
X-MC-Loop-Signature: 1789601258680:4214184305
X-MC-Ingress-Time: 1789601258680
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.63.247 (trex/8.0.2);
	Wed, 16 Sep 2026 23:27:38 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hlZmk0YVtzT3;
	Wed, 16 Sep 2026 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789601254;
	bh=N79yyICNek3QXouoyECywu8Y2dO9nu+pGip4A8AHeLY=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=bmPyZ52G9qJzw23l4mNJ4z5dGPL4hc3e+wUU/5kXROkbzLXEgx49yGD48azipZDKw
	 tDFw3Bv4J2I2NMDUHUiTJ+W+Fa4vrjnAC4XlNVRshC2YUYjh52m/KdV6KwoI2SYbm2
	 CMCo1+AcoTbtfdbJEIkJDRq6F/FFF+hFrWVB6Cw10QuDreZoTHjRQIDLHjXFIqaPH9
	 jFKhhCrJQMjbWG06hyRhU3Hw8C/bLEVYVPOyFtj8NgnMD+hwU10cMk5wDPdiaaRew2
	 eyGJnGLohEZYZCpyxzm2jKJHBxnXTLY7HSgz6VOERe1jbfeConvkmyTAm5hiB5IX5L
	 He8DLpwD7Pmzg==
Date: Wed, 16 Sep 2026 16:27:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 04/10] cxl: Add HDM-DB region creation
Message-ID: <20260916232731.voszaue7vwjzgdrz@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-5-dave@stgolabs.net>
 <20260909174808.BE31E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260909174808.BE31E1F000FF@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Wed, 09 Sep 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 1 potential issue=
(s) to consider:
>- [High] The device state flag `cxlds->bi` is read without proper synchron=
ization, leading to a TOCTOU race with concurrent reset handlers.

Urgh, I was able to reproduce this by artificially enlarging the racy windo=
w...
this is pure reset nastiness, but a valid catch. See below.

[...]

>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -314,6 +314,20 @@ static int cxl_region_decode_commit(struct cxl_regi=
on *cxlr)
>>	struct cxl_region_params *p =3D &cxlr->params;
>>	int i, rc =3D 0;
>>
>> +	/* a reset since attach may have invalidated cxlds->bi */
>> +	for (i =3D 0; i < p->nr_targets; i++) {
>> +		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>> +		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>> +
>> +		if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
>> +		    cxl_root_decoder_is_bi(cxlr->cxlrd) && !cxlmd->cxlds->bi) {
>
>[Severity: High]
>Is there a potential TOCTOU race here with concurrent reset handlers?
>
>If a userspace-initiated PCI reset (e.g. pci_reset_function()) runs
>concurrently with cxl_region_decode_commit(), the reset path can call
>cxl_reset_done() -> cxl_bi_reset_detected(), setting cxlds->bi =3D false
>without holding the cxl_rwsem.region lock.
>
>If this reset happens exactly after this unprotected read of cxlds->bi, but
>before the endpoint decoder is programmed, could the decoder be committed
>with BI enabled via MMIO even though the device-wide BI capability is now
>turned off?
>
>Because the decoder was not yet committed when the reset occurred, it
>appears cxl_endpoint_decoder_reset_detected() would evaluate to false. This
>would bypass the kernel taint and critical warning, potentially leaving the
>hardware in a silently mismatched state.

Using the region rwsem in reset_done() would not solve this because it only
orders the notification, not the hardware reset, so we need to account for
the full window. We need a hardware check after the commit is done (and res=
et
if detected). The current BI/reset check we have for the case where
reset_done() has already run is still valid as.

I am folding the following for v9:

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c57c6474a8a1..3118fb8ea085 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -231,4 +231,10 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, cons=
t uuid_t *feat_uuid,

  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
					   struct cxl_dport *dport);
+static inline bool cxl_bi_decoder_enabled(void __iomem *bi)
+{
+	return FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
+			 readl(bi + CXL_BI_DECODER_CTRL_OFFSET));
+}
+
  #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4a504afbf78b..af11bb5171ab 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1371,8 +1371,7 @@ void cxl_bi_reset_detected(struct cxl_port *endpoint)
	if (!cxlds->bi)
		return;

-	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
-		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
+	if (cxl_bi_decoder_enabled(bi))
		return;

	dev_warn(cxlds->dev, "BI disabled by reset\n");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index da83700f81ca..81ed30c34db5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -361,6 +361,28 @@ static int cxl_region_decode_commit(struct cxl_region =
*cxlr)
		}
	}

+	/*
+	 * Ensure that a reset did not come in between the cxlds->bi check above
+	 * and while committing the decoders. Consult the hardware state.
+	 */
+	for (i =3D 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
+		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
+		void __iomem *bi =3D cxled_to_port(cxled)->regs.bi_decoder;
+
+		if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
+		    cxl_root_decoder_is_bi(cxlr->cxlrd) &&
+		    !cxl_bi_decoder_enabled(bi)) {
+			dev_err(&cxlr->dev,
+				"%s:%s BI disabled by reset during commit\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev));
+			cxl_region_decode_reset(cxlr, p->nr_targets);
+			return -ENXIO;
+		}
+	}
+
	return 0;

  err:

[ ... ]

>
>> @@ -2105,10 +2118,31 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
>>		return -ENXIO;
>>	}
>>
>> -	if (cxled->cxld.target_type !=3D cxlr->type) {
>> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> -			cxled->cxld.target_type, cxlr->type);
>> +	/*
>> +	 * Verify the device and HDM are capable of the region's flavor before
>> +	 * proceeding. The endpoint decoder's target_type is then inherited
>> +	 * from cxlr->type later in cxl_rr_assign_decoder().
>> +	 */
>> +	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
>> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
>
>[Severity: High]
>Does this read of cxlds->bi during region attach also need synchronization?
>
>While a race in this earlier phase might be caught by the second check in
>cxl_region_decode_commit(), both reads appear to happen without protecting
>against concurrent modifications from PCIe resets.

Yes, it is caught later, and now caught by hardware. So a stale cxlds->bi
here has exactly one consequence, a region carrying a target whose device
has since lost BI =E2=80=94 and that region cannot commit: the pre-check re=
fuses
it if .reset_done has run, the hardware recheck refuses it if it hasn't.

>
>> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>
>--
>Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909170302.155=
0680-1-dave@stgolabs.net?part=3D4
