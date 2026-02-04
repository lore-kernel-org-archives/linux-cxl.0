Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A3395D84
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241468; cv=pass; b=ZY86TQrpkzATr9/gDtWpqt+NmLlDb6a4qfP7hqXQw1JGB5g4TjkQqHkm18tNktLuGRIeVQkegUl56EdnmHACfKz5YKjtrchcDNXdlvm4PcsevrTAKJoVoXvEW/SJXWrO0ZOcq340ycf1E7tXci3UCyHJcPC1w9s8kPdIRDU//Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241468; c=relaxed/simple;
	bh=XiC3XKg42vP1HZiYxp7K1lGQws3p+wVAqoNNx2J6hJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTvmM4a36ydanfCxfRJgboyCpHS6hHwPkYHahZT7WCotsf+jUZ1I6KWFVacPRdMNctsdmCgOkut1Pks6ana1H1PtpphTGhtJmB6ocJ1QhIM8o66EJtkEaq1vwJS04Pnjr2InZp+1JezU6/htNo6u9SMrplfru7ANOI0eTlJOSPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKDJR72+; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKDJR72+"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233c155a42so446054c88.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 13:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241467; cv=none;
        d=google.com; s=arc-20240605;
        b=KGj/daKTyLOr/E9g2FX7SL92aKUbqi/uddHI0SJONQ4fkWkXjUHmQn0Piqz1Wx5OzO
         u/qW3My1rTbVCYca7g/WCdPYBeNW+lDLs1NwzU2h0KKQANoiNY/Ez1Rk4kM0XuWRX60l
         QGojbag4QhhZvxdUewc4+Qk8rgjtHu9lEPkf53RnsFCwhNFZ4LtHWiM7V5JNChyLheeg
         OERx66E2YOn83paiIzzj6CYC3yuPXbOHfBtqgD6QtSg5CX1vRxIRp+uDHSQ9Y0aWcDiE
         5dRgtrG2yfNXILAcHN3QpHa7v3kUp8HdJukcbA57MVN1VzKqOu6eNPWr8Q5AlVrrhu46
         pr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
        fh=0ggszPZRkdZWlj3NBEobrPwH73SszMfemppTKJRGKwQ=;
        b=CdxhdvcNmYZA+SKNxTj5UJPjiiisZGc/zs2jJpNTdI7JR0dTtF9Pkas2ascrrV3T3H
         hulOWmU9vJkys1+qm6dPtrGl5ivoTbgJ7nFS/ciM2LfgDAL8oNF1iSYtIY2kQlhdZIBM
         vjccIdUnsHvoPRCCGuNzywPe1p70kMq8UqTLY7AnrUehhQBCd6juzUYGXmhg0K2sd4o6
         Ppbt7ZhPVOa/iDvzXjU1i5eWz2sL4N0LGWwbqD2fV6tBlQlluI1175okccpiRo93anY6
         4E4uWs/6qwokx9r3p0SyIm1l6JX0VEYY+eVEtYx0hJ8+KADdxtatYGqDw//GVKHfaCst
         Obsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241467; x=1770846267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
        b=lKDJR72+DRBzOiEPQS909/sb9LJ9tI3iXHMXANAR24fjc8VEHIBZCZJzK7LMXQzHgp
         +OurkMEK23DwRhyXd1fGiRdgCPl/BmRPbvjOu86Sp4H5STWa7Gza5fM+MSSzvHzAPJkS
         ua2zCKbDZp2JyCQVwJVo5cPnOUbszV5kZ2oC+i+Y7KJqLDZiVQsF80Bm/8UKTXyS/ahi
         rEZg5IbggkhaTTHORFrcIjAUlAv+TqbvfOLoJ0HBJZ4LkKZHgbn38fSqx7Eb74JjyTc8
         YkLvBBAl+v6bu8hOgyK2gqSZE3fE3kFxoc8+DP2QkEKyOIHXKrnIV9QcilLrqQoefq6Q
         LT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241467; x=1770846267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
        b=YT+WCbxSBpr4Ff8MHkx7F9Z+WkkN2ZXxXQnAUs8dgEdTS51ns7UR+xhkbeHxJA08+9
         XlfbGH6wZhMdcQp7pXfo3iPHO4Jospvwu+EBmKV9ER5ygO7nUsht3Q07npWxNqY/oabE
         0WXNzHZELD1J5NymhfnmlyyLjk1LtPCr3jeGCcQsYco31bKhckgl3Uyzv/6ZvyRcFT8q
         OLHXkEfAqhW6SZWLMjZNVnUA53Vcsoe44RvcqM67MFbtPbjgtjYlZuEaXesERWkvCpIy
         ZJOCxUAVZzbeK8wI4cMvovyvqZuRv7j5ctUkQN4dgedZQiibwrDdNlZEIXSKlk3M/CeJ
         f6lg==
X-Forwarded-Encrypted: i=1; AJvYcCVGlTkxwBxLhmkdStUFPPQG8mbaj+n/EtoX0SIFZvpYGuMQ6KTUbKpsKeHL9NfomDeV/ARrHZZdqAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lrTtd4wMNFGenpRfj84/WYktmtK1gP+3iosi2xIQO+OUYVeT
	E89EBu/fNyxsBiyhc/WlxGHKUbY99HjFNY16/uTMY4CfKM3g5KcqAU0ApWSAr6s9fAWbUdGzM5P
	jixGle7JwOEYkCTHjIL61Pu9cewCkxP1AI9fkrA==
X-Gm-Gg: AZuq6aLVm/cz9uzojg73uoeVWWU7rGrVdMm5foM5RDjiS5dBUWlq6cGDpQV4EtmMIe2
	c7GV0KzOKrLTTLHhFEmHiezdTbg7aIYY/c4QUT1l4g81Rp+5NhdWWyvyFah5pqVyK5/XsJkDLpX
	NVF09IbcFCIjT42O4wfHoe5E84PrpCCeGmCV3mW4fnJ+8CHj7cxFJsqwqJ4XO2TN1NWqQcju3Zb
	6ouBJ2L0uVQkPCek/9F5t3j/0eBhMK4IWyjKWIGcKf8qJIdLYvpxRo+lWL+1Rs2TF551I8=
X-Received: by 2002:a05:7022:403:b0:11e:3e9:3e9f with SMTP id
 a92af1059eb24-126f48ee2cemr1851333c88.50.1770241467170; Wed, 04 Feb 2026
 13:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> <20260119111542.788389-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-5-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:44:14 -0800
X-Gm-Features: AZwV_Qgepb2j0CPBa1ynab4EN2iLg4ekEsMtjEklsND7qpJKBHYIWjjvjqEGAeI
Message-ID: <CALa+Y15pZYQU3xB+5xudhPiJVKwd29k0g+itFSgydPoGLoqi_Q@mail.gmail.com>
Subject: Re: [PATCH qemu v4 4/5] hw/cxl/events: Updates for rev3.2 DRAM event record
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
> CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
> has updated with following new fields.
> 1. Component Identifier
> 2. Sub-channel of the memory event location
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Volatile Memory Error Count at Event
> 5. Memory Event Sub-Type
>
> Add updates for the above spec changes in the CXL DRAM event
> reporting and QMP command to inject DRAM event.
>
> In order to ensure consistency update all specification references
> for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: Update spec reference in related command as well (Markus)
> v3: Update all spec references for this command to 3.2 for consistency
>    (Markus)
> ---
>  qapi/cxl.json               | 33 ++++++++++++++++++++++-------
>  include/hw/cxl/cxl_events.h |  9 ++++++--
>  hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  7 +++++++
>  4 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4ff66fc6c16c..1dc8b08ca301 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -131,21 +131,21 @@
>  ##
>  # @CXLDRAMEvent:
>  #
> -# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> +#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
>  #     Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
> +#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
>  #     Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
>  #     DRAM Event Record, Memory Event Type for possible values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
> +#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -169,6 +169,21 @@
>  # @correction-mask: Bits within each nibble.  Used in order of bits
>  #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-channel: The sub-channel of the memory event location.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cvme-count: Corrected volatile memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLDRAMEvent',
> @@ -177,13 +192,17 @@
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint=
32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> -            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            '*sub-channel':'uint8',
> +            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
> +            'sub-type':'uint8'
>             }}
>
>  ##
>  # @cxl-inject-dram-event:
>  #
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
>  # This event type is reported via one of the event logs
>  # specified via the log parameter.
>  #
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 352f9891bd36..a3c5f2ec20e6 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -138,7 +138,7 @@ typedef struct CXLEventGenMedia {
>
>  /*
>   * DRAM Event Record
> - * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
> + * CXL r3.2 Section 8.2.10.2.1.2: Table 8-58
>   * All fields little endian.
>   */
>  typedef struct CXLEventDram {
> @@ -156,7 +156,12 @@ typedef struct CXLEventDram {
>      uint8_t row[3];
>      uint16_t column;
>      uint64_t correction_mask[4];
> -    uint8_t reserved[0x17];
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t sub_channel;
> +    uint8_t cme_ev_flags;
> +    uint8_t cvme_count[3];
> +    uint8_t sub_type;
> +    uint8_t reserved;
>  } QEMU_PACKED CXLEventDram;
>
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d03a9f0edc29..3da538bafb64 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1783,6 +1783,13 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_ROW                              BIT(5)
>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
> +#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
> +#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
> +#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
> +
> +#define CXL_DRAM_EV_DESC_UCE                            BIT(0)
> +#define CXL_DRAM_EV_DESC_THRESHOLD_EVENT                BIT(1)
> +#define CXL_DRAM_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
>
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>                                 uint32_t flags,
> @@ -1802,6 +1809,12 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log,
>                                 bool has_column, uint16_t column,
>                                 bool has_correction_mask,
>                                 uint64List *correction_mask,
> +                               const char *component_id,
> +                               bool has_comp_id_pldm, bool is_comp_id_pl=
dm,
> +                               bool has_sub_channel, uint8_t sub_channel=
,
> +                               bool has_cme_ev_flags, uint8_t cme_ev_fla=
gs,
> +                               bool has_cvme_count, uint32_t cvme_count,
> +                               uint8_t sub_type,
>                                 Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1888,6 +1901,35 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log,
>          valid_flags |=3D CXL_DRAM_VALID_CORRECTION_MASK;
>      }
>
> +    if (component_id) {
> +        strncpy((char *)dram.component_id, component_id,
> +                sizeof(dram.component_id) - 1);
> +        valid_flags |=3D CXL_DRAM_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
> +        }
> +    }
> +
> +    if (has_sub_channel) {
> +        dram.sub_channel =3D sub_channel;
> +        valid_flags |=3D CXL_DRAM_VALID_SUB_CHANNEL;
> +    }
> +
> +    if (has_cme_ev_flags) {
> +        dram.cme_ev_flags =3D cme_ev_flags;
> +    } else {
> +        dram.cme_ev_flags =3D 0;
> +    }
> +
> +    if (has_cvme_count) {
> +        descriptor |=3D CXL_DRAM_EV_DESC_THRESHOLD_EVENT;

Same issue as the general media event patch - the modification to
 'descriptor' is not written back to dram.descriptor which was assigned
earlier.

> +        st24_le_p(dram.cvme_count, cvme_count);
> +    } else {
> +        st24_le_p(dram.cvme_count, 0);
> +    }
> +
> +    dram.sub_type =3D sub_type;
> +
>      stw_le_p(&dram.validity_flags, valid_flags);
>
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 2047e9784694..231dda263fa4 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEv=
entLog log,
>                                 bool has_column, uint16_t column,
>                                 bool has_correction_mask,
>                                 uint64List *correction_mask,
> +                               const char *component_id,
> +                               bool has_comp_id_pldm,
> +                               bool is_comp_id_pldm,
> +                               bool has_sub_channel, uint8_t sub_channel=
,
> +                               bool has_cme_ev_flags, uint8_t cme_ev_fla=
gs,
> +                               bool has_cvme_count, uint32_t cvme_count,
> +                               uint8_t sub_type,
>                                 Error **errp) {}
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> --
> 2.48.1
>
>
