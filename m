Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2414F4D12
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630910; cv=none; b=U6lEyvwYiKKixPG2RNAigz/opwuH/m1xsc1I96ThvMCtox4siJJvkY6wvGlRkrc+SflylZuj6JzVDM/SUuk4K14kUuM6wTtwuwrCl/32LMx7h7h9hw7L1aJuP9Oc/T4I0N7xoMXVLVnCP9Arn9EDimQsoLztZQqAJsMwwkym9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630910; c=relaxed/simple;
	bh=o25pH90ktdMR8C5Ww2uqjTbs9ER9pkBtlB23DAW2mME=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoOVxKiue7ixa5zNfcx+/KbKRmwF/YwuXXdHQYjWDdCacpyHpe+pyTtXzC3L5C6RUkTfZ0tp05lMVvAj75g/0u3Q956ODGj0TUlxUdRmHPHkzveo7di2dBSPhz70zahYlHqAh9wrma1Y/3GMlYuIdxQJb7q+UlTZsIn5Kxkdruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLTzp5y/; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLTzp5y/"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1b327so2892920d50.0
        for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790630907; x=1791235707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qI014fJCRhW95oyB1i5MyERn5BvJEVpI3L2yMxBe1Nc=;
        b=pLTzp5y/9+RYYMCo7wJ5K91omHCcq81CJ+PeDpMUMiI3O7rBXyfan0458q8lVwVxav
         nI+y8jrIe123aZTWhXiy7wRhZrViq/Y0RDTRNWAbShEyCBJ3MR9glRpqAxLXkJsAh2Go
         9L+OZCdlBiiKYBbs9XV9wC8KDphK/Q4ON4whoMn0K/x6MI3rsSgOz4tiwMKTLAX2QWlP
         jbdpgtdrP97gJRYJG+t3ZxSCIL03+53N7RBW23i1gApt5WLIUiT7iw1ysyilZGGYqtuK
         wmiloyXsAwGdn4THlO5yu++Vw03FMBUPtk82WW90FfJQpumzvRg7+g4egNDVjb1ApIP5
         O+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790630907; x=1791235707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qI014fJCRhW95oyB1i5MyERn5BvJEVpI3L2yMxBe1Nc=;
        b=zTS0vEZZoImueHdUyd6jWbCxOdXyj0RTJKcJTu+P94lMUoOWiH2WItp6UzFzLfhCgn
         2unzEilq1eXqh5OeM2leq6fE2IUcrOZpYnl25utob9ylzASVs6fhXEqoRaEDO/5K9ZxO
         bzkIUSFxTGnK2IVgAKsVZT/Qbh7mc3vstFFV7GTnvcESu8Sehmxi2GyOsAFZvC2muypn
         zvoa2jteQ/NJBCvE/YwZrPel6HA64sraLMTTnR21dp2Dsc0f9uFAsy6CrrElzuPtomri
         BBpsoaZREBLRh1Avst8MyZiWdhGON5JmJMJTczzbSrGZcI5M2r4Vth2RwQn6n07gIYVA
         nwzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzntOLfbsTI0kFwSLl5phK5dI/mVN5RuvPLV8psnrvjvvTtm9C0tyVnmj6HnXVd9VPJ+JpKmd+2Kxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJMyK/KUIIg3aNTarPv8NkrfKbaGuPMlD9s0k7dMFumwCmrROb
	9nWr9ZyIE5MbBRjQzfhUpk3OoOAs19cs0qzN6XPyNPKCNl7U7JGwhNnh
X-Gm-Gg: AYBFou2y0abzUjjC4enqtAAEPGJ9H0LWFnFxn6dVJuZXcMEdvsyC05M7ivyJCP60eq9
	VCFKAALECqw2DUVzmkzNVJNTRgnma32uquXYBuwZyAk9joKg8xskrUVrL2cv/HZNq+uuZGVLTgE
	X1cn9hrhLfUWsEny6K3D4jiB+WCHioruzPplfRap0Lk5IKVKh7+1biu6W16Ru6DcJzNjPBuW4Dv
	WRyZPNmQdkwzB3onF2+5K8Idwcy0IDZTeY8R1MUsy0naE4XPOVwD0kktzKNjEze5G1Sgi+sfeJB
	qsSllaw8aTVc3yOMiYoSrjWWNNn98+vPgh5mZn+mODE3dSIqX9Wa87FIpSk18dSRQNwohF5r5EJ
	yWAqu6znhmjslyyhMm1W7zrkfDecsxYGL0EOCvQrehhGCo4ADEQNSH7uuq3g1QESkP0bmIN1r15
	u66/SYC3HSMi/zcd2csdptFbI81V6bujJXtgs2PKvWkyGof1hTUTwHDeYc+O1EMuTb1HxRdGLwT
	TrHgA0rJ559CfhZb5vRHGbiJJGPr7ln+NbWpMuN6518TjpUX7swujp6DblA
X-Received: by 2002:a05:690e:4395:b0:675:34b8:78c1 with SMTP id 956f58d0204a3-67534b88332mr1920551d50.19.1790630907018;
        Mon, 28 Sep 2026 14:28:27 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab3ad11ca3sm5698487b3.26.2026.09.28.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:28:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 28 Sep 2026 14:28:24 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH -qemu-jic23] hw/cxl/cpmu: Add CXL 4.0 event groups and
 Channel/Rank/Bank filter
Message-ID: <arrb-Jm9r4twcI53@4470NRD-ASU.ssi.samsung.com>
References: <20260715190050.458288-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715190050.458288-1-dave@stgolabs.net>

On Wed, Jul 15, 2026 at 12:00:50PM -0700, Davidlohr Bueso wrote:
> Advertise FILTERS_SUP bit 1 and implement Filter ID 1 (CRB), widen the
> per-counter filter values to the full 32-bit VALUE field (previously
> stored as bool), and add the CXL r4.0 Table 13-5 DDR Interface,
> Queue Occupancy, Queue Residency, Retry and Throttle event groups.
>
Tested-by: Anisa Su <anisa.su@samsung.com>
 
Tested briefly w/7.3-rc2 guest with basic topology that has 1 cxl-type3:
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=512M
  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=1M
  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true
  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2
  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0xabcd
  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k


DRAM activate counter success:
root@gost-temp02:~# perf stat -e cxl_pmu_mem0.0/ddr_act/ -a sleep 1

Performance counter stats for 'system wide':

    87960930222110      cxl_pmu_mem0.0/ddr_act/                                               

       1.004537620 seconds time elapsed

CRB filter can be applied:
root@gost-temp02:~# perf stat -e 'cxl_pmu_mem0.0/ddr_act,crb_filter_en=1,crb=0x12345678/' -a sleep 1

Performance counter stats for 'system wide':

    87960930222110      cxl_pmu_mem0.0/ddr_act,crb_filter_en=1,crb=0x12345678/                                      

       1.002889521 seconds time elapsed



> Introduce named constants for the event vendor IDs, group IDs, event
> masks and filter IDs, replacing the raw hex values in cpmu_read().
> 
> Also fix the FILTER0_CNT2 write case, which was missing the value
> store.
> 
Maybe worth splitting the naming refactor and FILTER0_CNT2 to separate patches
if this patch moves forward?

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> This only applies to Jonathan's qemu tree (latest branch), but it would
> be a good time to bring up if the cpmu support will ever be considered
> for upstream qemu inclusion.
> 
I think the 2 main limitations from Jonathan's original RFC [1] are that the
counters are fake and the CPMU instances are hard-coded per component. Whether
that's worth doing at this time, not sure.

[1] https://lore.kernel.org/qemu-devel/20220831153336.16165-1-Jonathan.Cameron@huawei.com/

Thanks,
Anisa
>  hw/cxl/cxl-cpmu.c         | 117 ++++++++++++++++++++++++++++++++++----
>  include/hw/cxl/cxl_cpmu.h |  20 +++++--
>  2 files changed, 121 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cpmu.c b/hw/cxl/cxl-cpmu.c
> index a25e6fa554f7..b0f5d1d28ed2 100644
> --- a/hw/cxl/cxl-cpmu.c
> +++ b/hw/cxl/cxl-cpmu.c
> @@ -14,6 +14,36 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  
> +/*
> + * Event Vendor IDs. The CXL-defined Event Groups (CXL r4.0 Table 13-5)
> + * are scoped by CXL_VENDOR_ID; any other Vendor ID is vendor specific.
> + */
> +#define CPMU_VID_HUAWEI 0x19e5
> +
> +/* CXL r4.0 Table 13-5 Event Group IDs */
> +#define CPMU_GID_BASE        0x0
> +#define CPMU_GID_D2H_REQ     0x10
> +#define CPMU_GID_H2D_REQ     0x12
> +#define CPMU_GID_DDR         0x8000
> +#define CPMU_GID_QUEUE_OCC   0x8001
> +#define CPMU_GID_QUEUE_RESID 0x8002
> +#define CPMU_GID_RETRY       0x8003
> +#define CPMU_GID_THROTTLE    0x8004
> +
> +/* Supported Events bitmasks of the CXL r4.0 Table 13-5 Event IDs */
> +#define CPMU_BASE_EVENTS        0x1    /* 00h: Clock Ticks */
> +#define CPMU_D2H_REQ_EVENTS     0xFF   /* 00h-07h, arbitrary emulation subset */
> +#define CPMU_H2D_REQ_EVENTS     0xFF   /* 00h-07h, arbitrary emulation subset */
> +#define CPMU_DDR_EVENTS         0xFFFF /* 00h-0Fh */
> +#define CPMU_QUEUE_OCC_EVENTS   0xF    /* 00h-03h */
> +#define CPMU_QUEUE_RESID_EVENTS 0x3    /* 00h-01h */
> +#define CPMU_RETRY_EVENTS       0xF    /* 00h-03h */
> +#define CPMU_THROTTLE_EVENTS    0x3    /* 00h-01h */
> +
> +/* Supported Filter IDs, per CXL r4.0 Table 8-187 */
> +#define CPMU_FILTER_ID_HDM BIT(0)
> +#define CPMU_FILTER_ID_CRB BIT(1)
> +
>  static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      CPMUState *cpmu = opaque;
> @@ -28,7 +58,8 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
>          retval = FIELD_DP64(retval, CXL_CPMU_CAP, COUNTER_WIDTH, 48);
>          retval = FIELD_DP64(retval, CXL_CPMU_CAP,
>                              NUM_EVENT_GROUPS, CPMU_NUM_EVENT_GROUPS - 1);
> -        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FILTERS_SUP, 1);
> +        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FILTERS_SUP,
> +                            CPMU_FILTER_ID_HDM | CPMU_FILTER_ID_CRB);
>          retval = FIELD_DP64(retval, CXL_CPMU_CAP, MSI_N, cpmu->msi_n);
>          retval = FIELD_DP64(retval, CXL_CPMU_CAP, WRITEABLE_WHEN_EN, 1);
>          retval = FIELD_DP64(retval, CXL_CPMU_CAP, FREEZE, 1);
> @@ -42,26 +73,30 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
>          break;
>      case A_CXL_CPMU_EVENT_CAP0:
>          /* Event group 0, clock ticks */
> -        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, SUPPORTED_EVENTS, 1);
> -        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, EVENT_GROUP_ID, 0);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, SUPPORTED_EVENTS,
> +                            CPMU_BASE_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, EVENT_GROUP_ID,
> +                            CPMU_GID_BASE);
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0,
> -                            EVENT_VENDOR_ID, 0x1e98);
> +                            EVENT_VENDOR_ID, CXL_VENDOR_ID);
>          break;
>      case A_CXL_CPMU_EVENT_CAP1:
>          /* Random mashup */
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, SUPPORTED_EVENTS,
> -                            0xFF);
> -        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID, 0x10);
> +                            CPMU_D2H_REQ_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID,
> +                            CPMU_GID_D2H_REQ);
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_VENDOR_ID,
> -                            0x1e98);
> +                            CXL_VENDOR_ID);
>          break;
>      case A_CXL_CPMU_EVENT_CAP2:
>          /* Random mashup */
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, SUPPORTED_EVENTS,
> -                            0xFF);
> -        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_GROUP_ID, 0x12);
> +                            CPMU_H2D_REQ_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_GROUP_ID,
> +                            CPMU_GID_H2D_REQ);
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_VENDOR_ID,
> -                            0x1e98);
> +                            CXL_VENDOR_ID);
>          break;
>      case A_CXL_CPMU_EVENT_CAP3:
>          /* Random mashup - vendor specific */
> @@ -69,7 +104,47 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
>                              0xFF);
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP3, EVENT_GROUP_ID, 0);
>          retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP3, EVENT_VENDOR_ID,
> -                            0x19e5);
> +                            CPMU_VID_HUAWEI);
> +        break;
> +    case A_CXL_CPMU_EVENT_CAP4:
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, SUPPORTED_EVENTS,
> +                            CPMU_DDR_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, EVENT_GROUP_ID,
> +                            CPMU_GID_DDR);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, EVENT_VENDOR_ID,
> +                            CXL_VENDOR_ID);
> +        break;
> +    case A_CXL_CPMU_EVENT_CAP5:
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, SUPPORTED_EVENTS,
> +                            CPMU_QUEUE_OCC_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, EVENT_GROUP_ID,
> +                            CPMU_GID_QUEUE_OCC);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, EVENT_VENDOR_ID,
> +                            CXL_VENDOR_ID);
> +        break;
> +    case A_CXL_CPMU_EVENT_CAP6:
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, SUPPORTED_EVENTS,
> +                            CPMU_QUEUE_RESID_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, EVENT_GROUP_ID,
> +                            CPMU_GID_QUEUE_RESID);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, EVENT_VENDOR_ID,
> +                            CXL_VENDOR_ID);
> +        break;
> +    case A_CXL_CPMU_EVENT_CAP7:
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, SUPPORTED_EVENTS,
> +                            CPMU_RETRY_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, EVENT_GROUP_ID,
> +                            CPMU_GID_RETRY);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, EVENT_VENDOR_ID,
> +                            CXL_VENDOR_ID);
> +        break;
> +    case A_CXL_CPMU_EVENT_CAP8:
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, SUPPORTED_EVENTS,
> +                            CPMU_THROTTLE_EVENTS);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, EVENT_GROUP_ID,
> +                            CPMU_GID_THROTTLE);
> +        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, EVENT_VENDOR_ID,
> +                            CXL_VENDOR_ID);
>          break;
>  
>      case A_CXL_CPMU_CNT0_CFG:
> @@ -144,6 +219,15 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
>          retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT3_CFG, VALUE,
>                              cpmu->filter_value[0][index]);
>          break;
> +    case A_CXL_CPMU_FILTER1_CNT0_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT1_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT2_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT3_CFG:
> +        /* Channel/Rank/Bank filter - consecutive counters are 32 bytes apart */
> +        index = (offset - A_CXL_CPMU_FILTER1_CNT0_CFG) / 32;
> +        retval = FIELD_DP64(retval, CXL_CPMU_FILTER1_CNT0_CFG, VALUE,
> +                            cpmu->filter_value[1][index]);
> +        break;
>      case A_CXL_CPMU_CNT0:
>      case A_CXL_CPMU_CNT1:
>      case A_CXL_CPMU_CNT2:
> @@ -196,12 +280,23 @@ static void cpmu_write(void *opaque, hwaddr offset, uint64_t value,
>          break;
>      case A_CXL_CPMU_FILTER0_CNT2_CFG:
>          index = 2;
> +        cpmu->filter_value[0][index] =
> +            FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
>          break;
>      case A_CXL_CPMU_FILTER0_CNT3_CFG:
>          index = 3;
>          cpmu->filter_value[0][index] =
>              FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
>          break;
> +    case A_CXL_CPMU_FILTER1_CNT0_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT1_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT2_CFG:
> +    case A_CXL_CPMU_FILTER1_CNT3_CFG:
> +        /* Channel/Rank/Bank filter - consecutive counters are 32 bytes apart */
> +        index = (offset - A_CXL_CPMU_FILTER1_CNT0_CFG) / 32;
> +        cpmu->filter_value[1][index] =
> +            FIELD_EX32(value, CXL_CPMU_FILTER1_CNT0_CFG, VALUE);
> +        break;
>      case A_CXL_CPMU_CNT0:
>      case A_CXL_CPMU_CNT1:
>      case A_CXL_CPMU_CNT2:
> diff --git a/include/hw/cxl/cxl_cpmu.h b/include/hw/cxl/cxl_cpmu.h
> index 883212c439cd..d5c68edeaac7 100644
> --- a/include/hw/cxl/cxl_cpmu.h
> +++ b/include/hw/cxl/cxl_cpmu.h
> @@ -36,6 +36,11 @@ CXL_CPMU_EVENT_CAP(0)
>  CXL_CPMU_EVENT_CAP(1)
>  CXL_CPMU_EVENT_CAP(2)
>  CXL_CPMU_EVENT_CAP(3)
> +CXL_CPMU_EVENT_CAP(4)
> +CXL_CPMU_EVENT_CAP(5)
> +CXL_CPMU_EVENT_CAP(6)
> +CXL_CPMU_EVENT_CAP(7)
> +CXL_CPMU_EVENT_CAP(8)
>  
>  #define CXL_CPMU_CNT_CFG(n) \
>      REG64(CXL_CPMU_CNT##n##_CFG, 0x200 + 8 * (n))                     \
> @@ -59,13 +64,18 @@ CXL_CPMU_CNT_CFG(3)
>  
>  #define CXL_CPMU_FILTER_CFG(n, f)                                       \
>      REG64(CXL_CPMU_FILTER##f##_CNT##n##_CFG, 0x400 + 4 * ((f) + (n) * 8)) \
> -        FIELD(CXL_CPMU_FILTER##f##_CNT##n##_CFG, VALUE, 0, 16)
> +        FIELD(CXL_CPMU_FILTER##f##_CNT##n##_CFG, VALUE, 0, 32)
>  
> -/* Only HDM decoder filter suppored - no effect on first counter */
> +/* Filter ID 0: HDM decoder filter - no effect on first counter */
>  CXL_CPMU_FILTER_CFG(0, 0)
>  CXL_CPMU_FILTER_CFG(1, 0)
>  CXL_CPMU_FILTER_CFG(2, 0)
>  CXL_CPMU_FILTER_CFG(3, 0)
> +/* Filter ID 1: Channel/Rank/Bank (CRB) filter */
> +CXL_CPMU_FILTER_CFG(0, 1)
> +CXL_CPMU_FILTER_CFG(1, 1)
> +CXL_CPMU_FILTER_CFG(2, 1)
> +CXL_CPMU_FILTER_CFG(3, 1)
>  
>  #define CXL_CPMU_CNT(n)                     \
>      REG64(CXL_CPMU_CNT##n, 0xc00 + 8 * (n))
> @@ -77,12 +87,12 @@ CXL_CPMU_CNT(3)
>  
>  typedef struct CPMUState {
>  #define CPMU_NUM_COUNTERS 4
> -#define CPMU_NUM_EVENT_GROUPS 4
> -#define CPMU_NUM_FILTERS 1
> +#define CPMU_NUM_EVENT_GROUPS 9
> +#define CPMU_NUM_FILTERS 2
>      bool counter_enable[CPMU_NUM_COUNTERS];
>      bool int_en[CPMU_NUM_COUNTERS];
>      bool freeze_en[CPMU_NUM_COUNTERS];
> -    bool filter_value[CPMU_NUM_FILTERS][CPMU_NUM_COUNTERS];
> +    uint32_t filter_value[CPMU_NUM_FILTERS][CPMU_NUM_COUNTERS];
>      uint64_t counter[CPMU_NUM_COUNTERS];
>      uint64_t overflow_status_bm;
>      uint64_t freeze_status_bm;
> -- 
> 2.39.5
> 
