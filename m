Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1724676D
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241622; cv=pass; b=qVLuzxVwc95E44r4r+TCmjShPU6HVGv8bAQ2jybY6btj5aTiAB2nexMwSSB/wxtDZRmTBJZ/Me/FdfKC2myuIqMXi6YFFY5Flx7+DVEMCqsZMLjkFSTlS3WqawlJa6OEvCyNvIOo9vvVBlcv/HyFYFhYqgUNi6Hj1hkVi7JShQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241622; c=relaxed/simple;
	bh=ejQcmQT+8NkkyFW8yOjv/8bR+a/8570tym7VjUaZh3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1ub7QFtWqSTSvTMGFkM+zUaTPMBOVr5kU2yuXGjLN2NpCOadz7KZPKY5QCtBUQ6Zpgf9btOzGWyWJrv84WUif2Co+t0rMvVteIogpILY8KJCmH6Gd/O4afYGN0EQiJAisOfve3RbrXYztuVgp0p1bhHWYwS/YBfwIqFFzaB67s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQCUSXBs; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQCUSXBs"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124a635476fso570823c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 13:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241621; cv=none;
        d=google.com; s=arc-20240605;
        b=a0gkh68lAYgXxuKPMDCeeOympRdphuisjOUFBkaYD0lw8+xN1xjtQ9ccvrlGpX89Cx
         JnkBXyRpwemnYyZdyUwKU3hMIHtky/TZ9vXuhaK9GSbUvNRYpKruR0Bc9Z7ectTiWuak
         cKCvy7lczvrPs7Bi3pxWEJEapWds9tzoodkV4zI4MpOsjwkSVgKYCLrAv7ykoa5OB5aH
         mrFpTUX++bzn98KAarWPx+zlukjmDcNjcf9chc1dw/MzKCFrU97yM0pkSxVVnSEyNzlI
         XRFDRBW2craTQRLBFTDj/SBPXERQJCabAACswAqpGeuh3ld+sSfQdlUhgs2jO+gi2b9M
         uoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
        fh=9LqRUBjV12akQYkvE0B8L0fe+it4dWY2G3YCcua8U54=;
        b=GSv+eRHXoOGlgvSczOksJY+MfkVq0TVhMrlwsPZdrF6ASSxQIAoxT/6UT6Gyql7h7K
         qVeeaMiZLwwf1rdKFdm8ric13hZyruDKeHpJKIbfKrk+OtlqG8bwF0LKKbQZba4Agkkr
         z/kIzJhDStEfuLBsrLeCR4Y31aGefyDMd26XobEvdDqe9WAB+1FM0Q5bj9TPlhBBklt9
         HcKLUke814ZY+zkLXp9Z5of2CDngHS3m6eVQuzxOMOgB8rT2UJMkWADdEp42ifnZwxx6
         /xPcsDbqtofGzeD8o9zuzWx5D65uY+0YQefqGpBz308v2LqLbT1AIakbPmn5Xv5p+HOq
         sjxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241621; x=1770846421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
        b=KQCUSXBs4EZeQCNTLLKhMvMgRIY5n67ysGIFZMe4iTYJz3nM0Ctbe058zLVAgm6ZaL
         WHfoQ1HPjX3Ow/kaTNioRcgLzRXaV1yVymFYAUpb7Jm6hNhIDY24ZkavJvLkTEDKOd5z
         xY42y6P/sLi8IpYk7pAXf6RgLzGzemY55AfPMJHbSuiGVXWj+qmS9D1jiW6WZa+eHc8G
         rNEFIq8/V98LeK/tUt+RoJV57/s2z8xx7ATT1DaMAVw2LdjTo4q0yc6WKdHG6HiU8pwr
         PlR+z64yLMaly+ISDMxrvXeVquyhWyyQN8aw5hf99WUnuv/uEJmRqlnpdr/Bqd05P4Wx
         zhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241621; x=1770846421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
        b=YiMrkG/BWPMRQBMxli75LdIfXEzjb3j11zgwUPs4xpt2zJXafIDp092DyhFu5G4+lm
         PJljl5r2KxWXK0HyjFDHUUs3Co0G/8rtqSEosLyXmANJSDaTTv2V7VqjvyD3bi6alZ9V
         8rpX5Mb7wcnRkTOVC1VQMPrfw4YvWxSJ7sCsw5B3UAm13KbDiG1UrrbXs7CD2CGAn2oC
         CoMJ21eWxKIi2864qldMMypgFrprr8Yj4THqijYXUy9NXevB8IyQqcSs3P1xajXgGmgE
         h+/YvMwfW9tHpedD20jYAg6UA7kk23IL+CoyO28WqPKBWy510nJnc0ZEUBN+1CrHnn7j
         vipA==
X-Forwarded-Encrypted: i=1; AJvYcCV/zT9qexvIqvCo3C/S8ZIzxeqGWT83LzVD1Mwr69/ZjBs6j91aTCBl8Xu8neNbjSMIZf6FJYvZgow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlDFmUgMXrkv/v/woSbe79LlYTvXb2mUGNlz7orFstRBMmLYl
	gyOJc6YmOJ3WwgJ4Cmjg1Bt8aSbN5zlHJZGcDX8Gye+IU3NRjaxYSbujUhiIHC/l595TmHTRwqN
	CdQ4yFbIJF3y3Mjvs3qNfohzp17wxgQ==
X-Gm-Gg: AZuq6aJMy+OhNyTom/LCi27oZkiNWmR/+Adw1r/ExZAIFFL99nchpfzXuCvIwpPgoWN
	cfvYSfD67PlXPpVdiWZ8PGc5eqzPlUDAc97JwUXqkSXq2dnLPIxJS2GKB8pt0ZjYTKPnw8t++aX
	BhGeoUDoCzIxYWrArcaU1KK+8CLgpg5TqqGGPhVL3J4cQv3fOGNaX+FugVTDTogkvefupy5LUme
	0HeW0YuZRQZERV+UCFqTjSzxOJQsozgvI5aKl7w+lFNbhOMz/8dmv9rnZj84DI55PiBH2Q=
X-Received: by 2002:a05:7022:6a1:b0:119:e55a:9bf6 with SMTP id
 a92af1059eb24-126f478e3c5mr1796566c88.18.1770241621438; Wed, 04 Feb 2026
 13:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> <20260119111542.788389-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-6-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:46:50 -0800
X-Gm-Features: AZwV_Qh3pdu43vYRi40T8RcKXzsoqh7kT818XSaxbGAsCpHsx5vB6kaswYq2rz8
Message-ID: <CALa+Y15qZgpNg+y2iujVN6zeYPB1JNXi0C4fbwWieGWtQ3UpbQ@mail.gmail.com>
Subject: Re: [PATCH qemu v4 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org, shiju.jose@huawei.com, 
	armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
	Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:18=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Updated all references for this command to the CXL r3.2
> specification.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v4: Update spec reference in the actual command as well (Markus)
> V3: Update spec references for whole command (Markus)
> ---
>  qapi/cxl.json               | 30 ++++++++++++++++++++----------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 1dc8b08ca301..81d6198ba030 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -214,20 +214,20 @@
>  ##
>  # @CXLMemModuleEvent:
>  #
> -# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
> +# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
>  #
> -# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
> +# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
>  #     Event Record for bit definitions for bit definiions.
>  #
> -# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Health Status for bit
> +# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Health Status for bit
>  #     definitions.
>  #
> -# @media-status: Overall media health summary.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Media Status for bit
> +# @media-status: Overall media health summary.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Media Status for bit
>  #     definitions.
>  #
> -# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
> +# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
>  #     Payload, Additional Status for subfield definitions.
>  #
>  # @life-used: Percentage (0-100) of factory expected life span.
> @@ -243,6 +243,14 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-type: Device event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -252,14 +260,16 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            'sub-type':'uint8'
>              }}
>
>  ##
>  # @cxl-inject-memory-module-event:
>  #
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> +# Inject an event record for a Memory Module Event (CXL r3.2
> +# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
>  # at the time of the event.
>  #
>  # Since: 8.1
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index a3c5f2ec20e6..4a7836ad7227 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -166,7 +166,7 @@ typedef struct CXLEventDram {
>
>  /*
>   * Memory Module Event Record
> - * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
> + * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59

Minor Nitpick : Table reference in commit message should match code
reference of Table 8-59

>   * All fields little endian.
>   */
>  typedef struct CXLEventMemoryModule {
> @@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
>      uint32_t dirty_shutdown_count;
>      uint32_t corrected_volatile_error_count;
>      uint32_t corrected_persistent_error_count;
> -    uint8_t reserved[0x3d];
> +    uint16_t validity_flags;
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t sub_type;
> +    uint8_t reserved[0x2a];
>  } QEMU_PACKED CXLEventMemoryModule;
>
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3da538bafb64..4dc9b223f476 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1937,6 +1937,9 @@ void qmp_cxl_inject_dram_event(const char *path, Cx=
lEventLog log,
>      }
>  }
>
> +#define CXL_MMER_VALID_COMPONENT                        BIT(0)
> +#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
> +
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
>                                          uint32_t flags, bool has_maint_o=
p_class,
>                                          uint8_t maint_op_class,
> @@ -1953,11 +1956,16 @@ void qmp_cxl_inject_memory_module_event(const cha=
r *path, CxlEventLog log,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
>                                          uint32_t corrected_persist_error=
_count,
> +                                        const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
>      CXLEventMemoryModule module;
>      CXLEventRecordHdr *hdr =3D &module.hdr;
> +    uint16_t valid_flags =3D 0;
>      CXLDeviceState *cxlds;
>      CXLType3Dev *ct3d;
>      uint8_t enc_log;
> @@ -2000,6 +2008,18 @@ void qmp_cxl_inject_memory_module_event(const char=
 *path, CxlEventLog log,
>      stl_le_p(&module.corrected_persistent_error_count,
>               corrected_persist_error_count);
>
> +    if (component_id) {
> +        strncpy((char *)module.component_id, component_id,
> +                sizeof(module.component_id) - 1);
> +        valid_flags |=3D CXL_MMER_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_MMER_VALID_COMPONENT_ID_FORMAT;
> +        }
> +    }
> +    module.sub_type =3D sub_type;
> +
> +    stw_le_p(&module.validity_flags, valid_flags);
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) =
{
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 231dda263fa4..98292a931c16 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *pa=
th, CxlEventLog log,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
>                                          uint32_t corrected_persist_error=
_count,
> +                                        const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t le=
ngth,
> --
> 2.48.1
>
>
