Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141C395D80
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241332; cv=pass; b=HxzT7oWavyVEWkqu/pOEqXA9prS8hAmv0zYbHMOCPAuvxO6FkjjraWzIpAaoRuzrjp9VOn8ALGQB2MMee5htpwJAK4q64zJ3yNzGSwxcIxtLJcnppDSFa9cdRjgqyNWSszwfWG4Qitd86zRQfqlJEUZqyfaKn2hVRVOjx03pTOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241332; c=relaxed/simple;
	bh=qVHzOWY+XG1nffkVuw8ro6ThDyExmSKA9fLJtZycMz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqZiGyRvtrD4iSWC7xgCfk948IvebxsZagRknkWxkDN/nmIiHi3iD1V+Lq4o7ue5+RXTUr8cssmMzfNKj7Uga8rbvOCm7hanxgT8QEv2vLdHm8wSTirp7DG25hZJB6YcDHu/bk9vzPRSJd3sbGlq2k1wSq8QKJOfIIxeDb+Gj6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7VOIar8; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7VOIar8"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-124b117776fso310218c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 13:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241332; cv=none;
        d=google.com; s=arc-20240605;
        b=gLLzxTA/UcJa9NTKJWvfFoztoE30jKPfwPsIXIKfNBDdG4hzEtKTKDJduZyGh/DBl3
         vPtmoe5p34Vsd0hXwfwTquBPPRpjUrjsnKtYTjUTGLLxZzR+t1QGlua93AaC4wQLl4+7
         n6R/3rmDRKT2nexPc2NuzPCC5KxKvFxDG85bLa1rojwJ4OyOvoY+uz1ooxvPyel8dj4q
         Aw7KuCVct6YTGa14TVz+OfNkLn7LkDNmbXhngA2oq8HQ1ToiCA3D4OpDfrAKoVqiCAKi
         UQyKnFbHI2pmtWv0LEZclle8Oe6tRMAvLM+mHUBVuY/jDAzPrpD41cw77ueLfDb4dXoS
         11Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
        fh=xKBDeGn4G687fmxnBoS6/JeEFOFPmVwJB3Zr6L46big=;
        b=WRSZr0bZukbvG4LziRmvIRGrP9BLDRish1/wqYmTRq66mRbqOJbi5BWLLACUDxuyh5
         05vJYoMrneMFnGgowaKaBELQal0saOtFMJIgf8KfnnN7f9/83gXw7uAWnErFRe6XtS3l
         rM9GCNTy/OEoXvOwAVSq/pBpB4LFB0Eiv/vhXjjUa0FxAWwG7EWOFRUDFCb7BgC6RsWJ
         zyfHFKIhHkJxPoHqtj8RQhApc0YkEsIig8pjc3qo0ueySPhFdK4SGwDUbaLY2DbsGYS7
         0MLkV0iOIFulpb1iJomIJH80xZZuLuIl6Lr1WTgCqHXhL3R2YnpXB5LWdvCET+jsBvLg
         ngQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241332; x=1770846132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
        b=e7VOIar87+2Z6r6VV1gPIFIqMJgIKOdK8lwXtn3MG5i5kRktSPnU1Hr1tnx04KDokX
         89KzvpPlxig7xoYuXoW2OjnGx5qOb0274Ov5TJFhVrVi3/pN6ypimGboYKRAm7MbqQZB
         oFjZrsKkRZa7HWh1r+lihv4dDtMnoNfcPCnmadCeCEnlIH+neV2iYsDlsZbq9bdb5wUt
         LHELnyoKoe+/cYnmeX4IySAQP4JiPfywTWPdMZF89HtlUYK+n++pZgd2i9drUq/xCZaX
         RUE4eb1FtkXKkuvfhS73AeHIQGNvlhyC5LnTUwfIFFcvy4eEZH3PabM8XTAhNkyBNFWK
         Ulcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241332; x=1770846132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
        b=EOoK337KJjPqus1lBg7JjIXOwNIBEWtpPRz3S2TBs6fIDPKni/PLQqR9Hu7CqR8U1a
         kYh7ZjMYO1F5h9cdbKwlmgaGN0iNuSvCOrHDchncD+jFp23UD1QE+uufK/iypcnNND9h
         ZHrI69yDi4yajs/FSx2b3oi61II+FqDGR6xtwGBP5X48y4U7OanSPuZPNa0BVkxYTWrA
         c23Ry44WMtonWXERs4B0VrR70AQ5MH8cVvlodQjbyshRx4jR6w506yIMZUS56i+wczKk
         Ftu8TrOxxI2sl8wL857ONz3UQfnGqTdsLXDQh4of94vRnJsukENyigGieLKCPIlQPg/d
         OEpA==
X-Forwarded-Encrypted: i=1; AJvYcCVXa90gFlUOJk6mEiJ7icjLY6DIGZoOLTY54K+c+uIY2QjV+yzxWB3gOty2liEYYP+yHUJTGMNjNzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdouW/9IBSlzqMk565g3c71sD5EUgrVMNGJqG9x+xCvkholtA
	uyDW+jEeSNXXeFU3WaNHbL4hIYJBKAS+dXhY058RYKNVgONi55/Ju92RlL0vdUNOkMCqpvU+RN7
	puUlzoIgWuW/KyqJIaqJDDV8lHuKwsw==
X-Gm-Gg: AZuq6aK/3ISXGD5smAnE0xFE360EbeHKbLayV1wP31GsXrpzPlVmI8s1H3gsTKFGiTD
	qkO9QugD7xkR2qDSLdtWjj7RvYY8RllQk/J2Q9xlUrct98ldSvyaxxBHVImbAS40r3PORzb4+BH
	irwDq1GF1ZNEmUx1D8c9WExjBzRa5+nvRYXVlqtschbQIodsWPZI5vskkfZfMstaJIxwzxyNy+f
	qzjJRAvhG5twmSNqpVYcn9JTGddKKfNm9lk8L+XTDjzgjfrTaALaaEI6bbwLiL+3jGUIh0=
X-Received: by 2002:a05:7022:2506:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-126f478f949mr2206138c88.11.1770241331526; Wed, 04 Feb 2026
 13:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:42:00 -0800
X-Gm-Features: AZwV_Qim6-6gtJPN1ilsYZ97WF7on0oMm6F1Kq0bMDH0-DIhzDImPu1Ygl6JVDY
Message-ID: <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
Subject: Re: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org, shiju.jose@huawei.com, 
	armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
	Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:21=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 4. Support for component ID in the PLDM format.
>
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
>
> In order to have one consistent source of references, update all to
> references for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: Update the spec reference in the related command to 3.2 as well.
> (Markus)
> v3: Update all references to 3.2 for consistency.
> ---
>  qapi/cxl.json               | 29 +++++++++++++++++++++--------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 ++++++
>  4 files changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 82001c0591d8..4ff66fc6c16c 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -64,22 +64,22 @@
>  ##
>  # @CXLGeneralMediaEvent:
>  #
> -# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
> +#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
>  #     Media Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-43 General Media Event
> +#     information.  See CXL r3.2 Table 8-57 General Media Event
>  #     Record, Memory Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
>  #     General Media Event Record, Memory Event Type for possible
>  #     values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
> +#     to occur.  See CXL r3-2 Table 8-57 General Media Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -94,6 +94,16 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cme-count: Corrected memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLGeneralMediaEvent',
> @@ -101,13 +111,16 @@
>    'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            '*is-comp-id-pldm':'bool',
> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
> +            'sub-type':'uint8' } }
>
>  ##
>  # @cxl-inject-general-media-event:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# Inject an event record for a General Media Event (CXL r3.2
> +# 8.2.10.2.1.1).  This event type is reported via one of the event
>  # logs specified via the log parameter.
>  #
>  # Since: 8.1
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4d9cfdb621ea..352f9891bd36 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
>
>  /*
>   * General Media Event Record
> - * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
> + * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> -#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
>  typedef struct CXLEventGenMedia {
>      CXLEventRecordHdr hdr;
>      uint64_t phys_addr;
> @@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
>      uint8_t rank;
>      uint8_t device[3];
>      uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t cme_ev_flags;
> +    uint8_t cme_count[3];
> +    uint8_t sub_type;
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 371bd4dc6ab2..d03a9f0edc29 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1646,6 +1646,11 @@ static const QemuUUID memory_module_uuid =3D {
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
>  #define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
> +
> +#define CXL_GMER_EV_DESC_UCE                            BIT(0)
> +#define CXL_GMER_EV_DESC_THRESHOLD_EVENT                BIT(1)
> +#define CXL_GMER_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
>
>  static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>  {
> @@ -1677,6 +1682,12 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device=
,
>                                          const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        bool has_cme_ev_flags,
> +                                        uint8_t cme_ev_flags,
> +                                        bool has_cme_count, uint32_t cme=
_count,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1737,10 +1748,28 @@ void qmp_cxl_inject_general_media_event(const cha=
r *path, CxlEventLog log,
>          strncpy((char *)gem.component_id, component_id,
>                  sizeof(gem.component_id) - 1);
>          valid_flags |=3D CXL_GMER_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_GMER_VALID_COMPONENT_ID_FORMAT;
> +        }
>      }
>
>      stw_le_p(&gem.validity_flags, valid_flags);
>
> +    if (has_cme_ev_flags) {
> +        gem.cme_ev_flags =3D cme_ev_flags;
> +    } else {
> +        gem.cme_ev_flags =3D 0;
> +    }
> +
> +    if (has_cme_count) {
> +        descriptor |=3D CXL_GMER_EV_DESC_THRESHOLD_EVENT;

The modification to 'descriptor' here is not written back to gem.descriptor
which was assigned earlier in this function.

Suggest moving gem.descriptor assignment after this block, similar to
how valid_flags is handled in this same function.

> +        st24_le_p(gem.cme_count, cme_count);
> +    } else {
> +        st24_le_p(gem.cme_count, 0);
> +    }
> +
> +    gem.sub_type =3D sub_type;
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 91b1478114d9..2047e9784694 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -27,6 +27,12 @@ void qmp_cxl_inject_general_media_event(const char *pa=
th, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device=
,
>                                          const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        bool has_cme_ev_flags,
> +                                        uint8_t cme_ev_flags,
> +                                        bool has_cme_count, uint32_t cme=
_count,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> --
> 2.48.1
>
>
