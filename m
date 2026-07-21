Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBE3B47DF
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666208; cv=none; b=SEDHzX1UjI17z+bnhIo3y2cUS6b5pmkT6tZBndTkcBZ8vysJ4pzYcDZQiFcyDsH4vcfHzYa/WsyDshFQb5NoteTmGQPaAozutmwZ0+NmkdvtbsgKe8hPwCFF6nJweiixeQbl+6IUpfglF4532fL1SQrkjNlgYAk6KcRTKAYwOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666208; c=relaxed/simple;
	bh=nBBxizu71UDBDSfMdygy5bWmzACNt9QukQDTvTPRqEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU90KufvVMdeCQHDzwcWm6JdmgvermX3Sdd0yJOJiusgrcywu9GvM3u/ysuAXJIKaw4lXSR1wOQQNXh/ZpO3CGVWYK6oG1qXOvutbRIJEr/AHayA7ld7VNKe3crFV6DhLGjE92KHv3WaFjM82TzKn63z4r8PhQ6TYQBM+l5Rp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IpOITv4F; arc=none smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IpOITv4F"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D43FD415EF;
	Tue, 21 Jul 2026 18:13:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.104.248.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 58400400EC;
	Tue, 21 Jul 2026 18:13:33 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Tangy: 0effbd2a222a1b6a_1784657613672_4143679197
X-MC-Loop-Signature: 1784657613672:3722288848
X-MC-Ingress-Time: 1784657613672
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.248.19 (trex/8.0.2);
	Tue, 21 Jul 2026 18:13:33 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4h4QVh6vrLznR;
	Tue, 21 Jul 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784657613;
	bh=t8Rwsbw015Vz39S488orHNH7DGnTVlrAkwH7+pAXGYo=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=IpOITv4FEyasBu1puIo2JHmFKvvQFgcFEY2/68rlw7vRatMZ1hrwn/CZnBktNeiWv
	 nveG94CRWiSc4BQpuBC+djxJOY0CNSq1PbwODKVWMYl1+ABtNVYsWV2rlx8/w1E9TT
	 EY1Lsmqfd5iw4bQILCX3EEmG7HeGFADDEk13sCwUxi9FSrRxSjh0tB+1iXfvZeVzXE
	 w6m3RvF+tX8rlW/V/abIAg8j48Y5/PxTSPQtj+sqzMaV5UqfOIdK6ShQGA0x6jnyQG
	 jOSZ63Fq0/2IZD6evTZQfdB/+f0JyDH+WQR/oeJLX0twGL9IHcENKkf59Uc9TTIpRB
	 0XEuWOR5PGWbw==
Date: Tue, 21 Jul 2026 11:13:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Message-ID: <20260721181329.qphcckacosncwzka@offworld>
References: <20260615145529.13848-5-dave@stgolabs.net>
 <20260615174123.73B721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260615174123.73B721F000E9@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Mon, 15 Jun 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 3 potential issue=
(s) to consider:
>- [High] Auto-discovered regions fail to inherit their coherency type from=
 the root decoder, violating the design rule and potentially creating inval=
id region configurations.

False positive. As is already documented in the cover letter and patch 3,
a decoder committed with the BI bit set is rejected at enumeration time.

>- [Medium] Spurious `dev_WARN_ONCE` triggers in `cxl_rr_assign_decoder()` =
when attaching an endpoint decoder with a stale `DEVMEM` target type to an =
HDM-H (non-BI) region.

Yes, I was able to trigger this at least on qemu with two windows:
     https://github.com/davidlohr/cxl-bi-tests/blob/main/topos/t15-decoder-=
reuse.sh

See the fix below.

>- [Medium] `bi_show` incorrectly reports that an auto-discovered endpoint =
decoder is configured for HDM-DB (BI=3D1) when it is operating with BI=3D0 =
in hardware.

Yes. An auto-discovered HDM-D on BI device can make this show bogus
1 afaict. Adding a check for the region's root decoder bi addresses
this and also makes the check more robust: (&& cxl_root_decoder_is_bi()).

Another alternative is to cache the BI bit upon committing, but imo this
file should show 1 as soon as it is attached successfully.

>--
>
>commit 913c2a59fed5b8381543ceb7345cd15ac2ea9d17
>Author: Davidlohr Bueso <dave@stgolabs.net>
>
>cxl: Add HDM-DB region creation
>
>A region inherits its coherency from the chosen root decoder: HDM-DB
>if the root has CXL_DECODER_F_BI, otherwise HDM-H.
>
>[ ... ]
>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index c5aacd7054f1d..71801dfd614b1 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>
>[ ... ]
>
>> @@ -233,6 +234,19 @@ static ssize_t mode_store(struct device *dev, struc=
t device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RW(mode);
>>
>> +static ssize_t bi_show(struct device *dev, struct device_attribute *att=
r,
>> +		       char *buf)
>> +{
>> +	struct cxl_endpoint_decoder *cxled =3D to_cxl_endpoint_decoder(dev);
>> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.region);
>> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
>> +			  cxled->cxld.target_type =3D=3D CXL_DECODER_DEVMEM);
>> +}
>
>[Severity: Medium]
>Will this attribute show '1' for an auto-discovered DEVMEM endpoint decoder
>even if it operates with BI=3D0 in hardware?
>
>If Linux auto-discovers a DEVMEM decoder that intrinsically supports BI
>(cxlds->bi is true), init_hdm_decoder() currently rejects it if the BI
>control bit is set, so the hardware must be operating with BI=3D0. However,
>this attribute seems to evaluate the state dynamically based on the device
>capability rather than the hardware's actual BI configuration, contradicti=
ng
>the sysfs documentation that says it shows '1' when "currently configured".
>
>> +static DEVICE_ATTR_RO(bi);
>
>[ ... ]
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e50dc716d4e82..6eb852b514d3a 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1132,11 +1132,13 @@ static int cxl_rr_assign_decoder(struct cxl_port=
 *port, struct cxl_region *cxlr,
>>	/*
>>	 * Endpoints should already match the region type, but backstop that
>>	 * assumption with an assertion. Switch-decoders change mapping-type
>> -	 * based on what is mapped when they are assigned to a region.
>> +	 * based on what is mapped when they are assigned to a region. HDM-DB
>> +	 * endpoint decoders inherit their type from cxlr->type below.
>>	 */
>>	dev_WARN_ONCE(&cxlr->dev,
>>		      port =3D=3D cxled_to_port(cxled) &&
>> -			      cxld->target_type !=3D cxlr->type,
>> +			      cxld->target_type !=3D cxlr->type &&
>> +			      !cxl_root_decoder_is_bi(cxlr->cxlrd),
>>		      "%s:%s mismatch decoder type %d -> %d\n",
>>		      dev_name(&cxled_to_memdev(cxled)->dev),
>>		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>
>[Severity: Medium]
>Does this logic trigger a spurious dev_WARN_ONCE() when attaching an
>endpoint decoder with a stale DEVMEM target type to an HDM-H region?
>
>When a region is dismantled, __cxl_decoder_detach() clears the decoder's
>region assignment but doesn't reset its target_type, leaving it with a
>stale DEVMEM target type. If it is later attached to an HDM-H (non-BI)
>region, the check for cxld->target_type !=3D cxlr->type evaluates to true,
>and the !cxl_root_decoder_is_bi(cxlr->cxlrd) check also evaluates to true.
>
>Could this generate a spurious warning stack trace in dmesg during valid
>user reconfigurations, potentially causing a panic if panic_on_warn is set?

I ended up introducing a default type helper:

+/*
+ * HDMs that advertise support for both coherency modes
+ * (CXL_HDM_DECODER_COHERENCY_BOTH) default to host-only; the region
+ * attach path switches target_type to device-coherent if the region's
+ * root decoder has the CFMWS BI bit set. Only HDMs that strictly
+ * support device-coherent mode default to HDM-DB.
+ */
+enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxle=
d)
+{
+       struct cxl_dev_state *cxlds =3D cxled_to_memdev(cxled)->cxlds;
+       struct cxl_port *port =3D cxled_to_port(cxled);
+       struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
+
+       if (cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM &&
+           cxlhdm->supported_coherency !=3D CXL_HDM_DECODER_COHERENCY_DEV)
+               return CXL_DECODER_HOSTONLYMEM;
+
+       return CXL_DECODER_DEVMEM;
+}

=2E.. then use it in both init_hdm_decoder() (which we do already) and
__cxl_decoder_detach(), to reset.

>
>[ ... ]
>
>> @@ -2772,6 +2796,7 @@ static ssize_t create_region_store(struct device *=
dev, const char *buf,
>>				   size_t len, enum cxl_partition_mode mode)
>>  {
>>	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
>> +	enum cxl_decoder_type target_type;
>>	struct cxl_region *cxlr;
>>	int rc, id;
>>
>> @@ -2779,7 +2804,14 @@ static ssize_t create_region_store(struct device =
*dev, const char *buf,
>>	if (rc !=3D 1)
>>		return -EINVAL;
>>
>> -	cxlr =3D __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>> +	/*
>> +	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
>> +	 * produces an HDM-DB region; otherwise HDM-H.
>> +	 */
>> +	target_type =3D cxl_root_decoder_is_bi(cxlrd) ?
>> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
>> +
>> +	cxlr =3D __create_region(cxlrd, mode, id, target_type);
>
>[Severity: High]
>Does the auto-discovery path in construct_region() still blindly create
>regions using the endpoint decoder's type?
>
>The commit message dictates a strict design rule that a region inherits its
>coherency from the chosen root decoder. The sysfs creation path correctly
>enforces this here, but construct_region() appears to miss this update:
>
>drivers/cxl/core/region.c:construct_region() {
>    ...
>		cxlr =3D __create_region(cxlrd, cxlds->part[part].mode,
>				       atomic_read(&cxlrd->region_id),
>				       cxled->cxld.target_type);
>    ...
>}
>
>If firmware incorrectly programs an endpoint decoder as DEVMEM under an HD=
M-H
>root decoder, could construct_region() create a DEVMEM region? Because both
>the region and the endpoint have target_type =3D=3D DEVMEM, the mismatch w=
arning
>in cxl_rr_assign_decoder() would be bypassed, resulting in an invalid HDM-=
DB
>region under a root decoder that cannot generate Back-Invalidates.
>
>>	if (IS_ERR(cxlr))
>>		return PTR_ERR(cxlr);
>
>--
>Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260615145529.13848-=
1-dave@stgolabs.net?part=3D4
