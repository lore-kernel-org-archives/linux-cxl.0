Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7B1BC46
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240920; cv=pass; b=ZRVtlC9Ng2o3tC4Vl9COwkb0okcbpmwoLrH978NKTdBu9SLZwRDmEIEfdEYPlmuwJWIgxs7NIO9dOAOjS09YF+Stv4BNIcvtHSJIenI2ftl/IWez9iNVh/t3g3vqLh+sOEmjQcHxucGmOicCrUA6DNr4q2+NzUFmLFOMqxYJqTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240920; c=relaxed/simple;
	bh=v5WUHA9KLr1YAA+gWSthcQ+XiFLcC8QJE3EMKXqsas0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8TsYkz/ta1Dh2zC3AB/MZMnmn3p5mGZwfLSVdgpOmMpTZQ4u8miLBzlG/t62c0LX/i3WoWUs/R6I5wFiQNljKknperVgT67CsAIrFGcuLzUzzDyUUqBwvUEJXRVkk5s9ktWJS4fa8wvGeaqzdFzIRhw0tienIybo+FLCICoPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNJxA1JI; arc=pass smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNJxA1JI"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12460a7caa2so416386c88.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 13:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770240919; cv=none;
        d=google.com; s=arc-20240605;
        b=fTIwIXcQwlnu81bOzLWqttsKTUmVMtx586JVpjk7Kd6ohArj1ZTLc3cnbTJz6+a3zP
         RXtb2J79OscGO8cV1Uf73DAQQk3pymM59zHMYpMuYO9DWc4BmqUBxdmjvTsX6a+el332
         TRHV+g11RDZucPx1bIgh6gepwekLH2bBtPH3Rly+Gb3Rw0lFwAxCs0PNJxlUJ9vf9hLc
         A7MTJujaUJ0myIdv5pkpUISOw+Mx2I6Op51EDzWgw2ztLkYX6YDvilFsxRDePSB0NJCH
         whg1q4HvQtIL0uvfw0A8qDTgzZaZc2MdAT3EFPxH9fNOQSLMwhVPpNQWE7ryY61WiVhp
         fFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
        fh=HL8oCqyOY39thshCga5Nsyfm/FNVCS1FohF7b26eUPg=;
        b=dQdsgHRcgLLblZHiIzX1pfJ6P7gNMhll2mluC1ECQphgkMMU8rS/iYvF/ZOiWS+XEs
         tkv7rdCtlIOgT04qT2KJn6bMkNh8eDBAc721bOMKLTZ9n8vSW64bweWmp6EpKkT9h23U
         F7kc1SYm7cZRPpcr4va9xljOGv96Ptk9O6o3HN3NhxspdCUXr7bOCOUXfD3/WNJbs3rD
         8SFe4dOwKpu0o575lJ4B0060gXFuKaqSaG4C5bsUbsGre6M9vIoNrl2Q55nUlGxrNpO4
         05/Y6gisFjIW8hmAwoAFnsL2yOKTDdO66gK2yew1z4dkQWCm8W8l1Zog8FRNpGEwZgFo
         CWXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770240919; x=1770845719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
        b=VNJxA1JIh1EXcf/fFdMq7BJcYjjCChIX/L/RoeDrineQfy8atTuWCn5WoSUe01kGMN
         YuQaB+Fo55OE41Zk53Ia8i6v5C26I63qMUQdAS0kPYNrJT+uD17pFFcAOl1GEssiAXvY
         GEK+q6E+pKBvuy7C9+w+vEEiRiXUVBqZV6OAUATOrSCfJfYm3jazdRmGvPBqraCDIf8R
         CxnGnjB1Bci5BCZViHDBzgLTFE6XF9SgHNR6ZsJY62lnwWEea2esj3jMXY9cMfCPemsT
         2yBFhRCxJMSyJlPz6lVObd+I9j+u5Z1LEL0+3L9hQf9vVSrpPbDnijp09LAUflWimdWX
         ZHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240919; x=1770845719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
        b=VHLMXPgkvxdrrVzg0sRBu6qp9Mp0RfzvmRLyDfqRWoam+BSqXPQMqHa9jZPs+BwPT4
         qjEQVDs4Y8f7vJkBqniYhm8sF8e0IBs0uBXvU+pLXWIURhPwQXhLM3r4AHAKLeIMerkB
         eme491MKpxXgARqHOmA/a6vsKS4JObaO7CVNwdOg6HTammN5+Sz2Aa09P+n6LEgQaBDS
         D1dkFVvT37iaNLUylybHwNLwVDg4sEs0wAxDnnDGtFpFUySyEtLMXQiFzQsXkanaOvPD
         I74DA41dfYH6oYGZWl9TKJqcS0xmofeDTPrCFPwMe6Aad14QcuPdm3mphnBbjGDvFx9/
         PhnA==
X-Forwarded-Encrypted: i=1; AJvYcCXEh2OeNCtFNJSvgt9zof8R9ta3yZf/qwkGELE1ENbAUfsBbo4diALsFbOReXxXY+8PfVpxX7ZP4so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRyEs5td8VJRxa8SrvOBPP4El8xY9PcvKyDwUghLv932NVXl98
	UBQfpTzvat5qoLcmjOAcL7SVWhGYF+6uxxRO5HtvBsSbCL4nmeLJM1NZlXfNwSmU4WYb+GEnzjg
	eX8pYNjUCcQ+zfi+1yvO+YFTM/BYkQg==
X-Gm-Gg: AZuq6aKfm0NcLgWIp+SFKx/yCBSmdEV+Hy90xiFWPW5Yjgnt39yatlI9Is+R1jDb7qG
	UIdjNj2vUM1cmZ71oO7i5j9nmWEncZcF7Upr2JyURFeCXl1oZQet8kt68Yrhco+KsnyLJ1WiLW0
	8oTLbdEISu4RAYqSsIlOnCbdx3r8aWBEOtlySZ5wjTUsbqqjmwq5pb4DeB1UDBa/Yq49dM58aDf
	6bW4PUdwIXPeW6H6vcMRP2WNW3g2jcHOWofCztkz/slEw3uA85J9/xBmyfUJlnNHHTsN1E=
X-Received: by 2002:a05:7022:6b9b:b0:124:9e46:82fb with SMTP id
 a92af1059eb24-126f47d9bf5mr1768151c88.38.1770240919229; Wed, 04 Feb 2026
 13:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> <20260119111542.788389-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-3-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:35:07 -0800
X-Gm-Features: AZwV_QgkXMJg8jDxHD0sl5cCn0DBoKKDr62lcBMCAWXiD11iLe_MubokxRMQjtU
Message-ID: <CALa+Y16OT6Ew_fhC-Y_=E3N3E_eGHWt3yQuFJJS6Za1Wt8jMBg@mail.gmail.com>
Subject: Re: [PATCH qemu v4 2/5] hw/cxl/events: Update for rev3.2 common event
 record format
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org, shiju.jose@huawei.com, 
	armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
	Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:16=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> Update all related specification references to CXL r3.2 to ensure
> one consistent source.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Expand the LD acronym (Markus)
> ---
>  qapi/cxl.json               | 21 ++++++++---
>  include/hw/cxl/cxl_device.h |  7 +++-
>  include/hw/cxl/cxl_events.h | 15 ++++++--
>  hw/cxl/cxl-events.c         |  3 +-
>  hw/cxl/cxl-mailbox-utils.c  |  3 +-
>  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
>  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
>  7 files changed, 122 insertions(+), 21 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 55a088586e53..82001c0591d8 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -33,20 +33,33 @@
>  ##
>  # @CXLCommonEventBase:
>  #
> -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> -# Table 8-42 Common Event Record Format).
> +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
> +# Table 8-55 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
>  # @log: event log to add the event to
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to
> +#     initiate.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device
> +#     requests to initiate.
> +#
> +# @ld-id: Logical Device (LD) ID of LD from where the event
> +#     originated.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLCommonEventBase',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +            '*ld-id':'uint16', '*head-id':'uint8' } }
>
>  ##
>  # @CXLGeneralMediaEvent:
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 165355baf9da..e461a824b692 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -723,7 +723,12 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d,=
 uint64_t dpa,
>                                    uint64_t len);
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp);
> +                             uint8_t length, uint64_t timestamp,
> +                             bool has_maint_op_class, uint8_t maint_op_c=
lass,
> +                             bool has_maint_op_subclass,
> +                             uint8_t maint_op_subclass,
> +                             bool has_ld_id, uint16_t ld_id,
> +                             bool has_head_id, uint8_t head_id);
>  void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 758b075a64b9..4d9cfdb621ea 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
>
>  /*
>   * Common Event Record Format
> - * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
> + * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
>   */
> -#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> +#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
> +#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
> +#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4)
> +#define CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5)
> +#define CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6)
> +#define CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7)
> +#define CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
>  typedef struct CXLEventRecordHdr {
>      QemuUUID id;
>      uint8_t length;
> @@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
>      uint16_t related_handle;
>      uint64_t timestamp;
>      uint8_t maint_op_class;
> -    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +    uint8_t maint_op_subclass;
> +    uint16_t ld_id;
> +    uint8_t head_id;
> +    uint8_t reserved[0xb];
>  } QEMU_PACKED CXLEventRecordHdr;
>
>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 7583dd9162f6..5356dfb5b300 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -271,7 +271,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3=
Dev *ct3d,
>                              &dynamic_capacity_uuid,
>                              (1 << CXL_EVENT_TYPE_INFO),
>                              sizeof(event_rec),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            0, 0, 0, 0, 0, 0, 0, 0);
>      event_rec.type =3D type;
>      event_rec.validity_flags =3D 1;
>      event_rec.host_id =3D 0;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6cfdd98168f9..e9528da70cc4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3458,7 +3458,8 @@ static CXLRetCode cmd_fm_set_dc_region_config(const=
 struct cxl_cmd *cmd,
>                              &dynamic_capacity_uuid,
>                              (1 << CXL_EVENT_TYPE_INFO),
>                              sizeof(dcEvent),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            0, 0, 0, 0, 0, 0, 0, 0);
>      dcEvent.type =3D DC_EVENT_REGION_CONFIG_UPDATED;
>      dcEvent.validity_flags =3D 1;
>      dcEvent.host_id =3D 0;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6eb20137a04f..371bd4dc6ab2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1592,12 +1592,39 @@ void qmp_cxl_inject_correctable_error(const char =
*path, CxlCorErrorType type,
>
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp)
> +                             uint8_t length, uint64_t timestamp,
> +                             bool has_maint_op_class, uint8_t maint_op_c=
lass,
> +                             bool has_maint_op_subclass,
> +                             uint8_t maint_op_subclass,
> +                             bool has_ld_id, uint16_t ld_id,
> +                             bool has_head_id, uint8_t head_id)
>  {
> -    st24_le_p(&hdr->flags, flags);
>      hdr->length =3D length;
>      memcpy(&hdr->id, uuid, sizeof(hdr->id));
>      stq_le_p(&hdr->timestamp, timestamp);
> +
> +    if (has_maint_op_class) {
> +        hdr->maint_op_class =3D maint_op_class;
> +    } else {
> +        hdr->maint_op_class =3D 0;
> +    }
> +
> +    if (has_maint_op_subclass) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID;
> +        hdr->maint_op_subclass =3D maint_op_subclass;
> +    }
> +
> +    if (has_ld_id) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_LD_ID_VALID;
> +        stw_le_p(&hdr->ld_id, ld_id);
> +    }
> +
> +    if (has_head_id) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_HEAD_ID_VALID;
> +        hdr->head_id =3D head_id;
> +    }
> +
> +    st24_le_p(&hdr->flags, flags);
>  }
>
>  static const QemuUUID gen_media_uuid =3D {
> @@ -1637,7 +1664,13 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog =
log)
>  }
>  /* Component ID is device specific.  Define this as a string. */
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type=
,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channe=
l,
> @@ -1675,7 +1708,10 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>
>      memset(&gem, 0, sizeof(gem));
>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>
>      stq_le_p(&gem.phys_addr, dpa);
>      gem.descriptor =3D descriptor;
> @@ -1719,7 +1755,13 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_=
t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> +                               uint32_t flags,
> +                               bool has_maint_op_class, uint8_t maint_op=
_class,
> +                               bool has_maint_op_subclass,
> +                               uint8_t maint_op_subclass,
> +                               bool has_ld_id, uint16_t ld_id,
> +                               bool has_head_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -1762,7 +1804,10 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log, uint8_t flags,
>
>      memset(&dram, 0, sizeof(dram));
>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>      stq_le_p(&dram.phys_addr, dpa);
>      dram.descriptor =3D descriptor;
>      dram.type =3D type;
> @@ -1822,7 +1867,13 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log, uint8_t flags,
>  }
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
> @@ -1861,7 +1912,10 @@ void qmp_cxl_inject_memory_module_event(const char=
 *path, CxlEventLog log,
>
>      memset(&module, 0, sizeof(module));
>      cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(modu=
le),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>
>      module.type =3D type;
>      module.health_status =3D health_status;
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index c1a5e4a7c193..91b1478114d9 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -14,7 +14,13 @@
>  #include "qapi/qapi-commands-cxl.h"
>
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type=
,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channe=
l,
> @@ -23,7 +29,13 @@ void qmp_cxl_inject_general_media_event(const char *pa=
th, CxlEventLog log,
>                                          const char *component_id,
>                                          Error **errp) {}
>
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_=
t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> +                               uint32_t flags,
> +                               bool has_maint_op_class, uint8_t maint_op=
_class,
> +                               bool has_maint_op_subclass,
> +                               uint8_t maint_op_subclass,
> +                               bool has_ld_id, uint16_t ld_id,
> +                               bool has_head_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -38,7 +50,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEv=
entLog log, uint8_t flags,
>                                 Error **errp) {}
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
> --
> 2.48.1
>
>
No comments.

Reviewed-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
