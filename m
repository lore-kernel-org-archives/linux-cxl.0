Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE735208BD
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078580; cv=none; b=akxwpDIN7OR5XjyWCcDbKPgtABuzlpnGXTjrEpPWiZXsF+sthBUcSjNwjIwH4i29R8be88VeLT2YmHqdfY7CPCSuClvgT2MjKcYIvSf8r2FWFQaRIYu8dGS8X3gVK+lJLrSNxuXno+qrVTfg+U8JsMTSuXfHKlmVtLtG0aILNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078580; c=relaxed/simple;
	bh=AW4sMhNGBSJqqpCOG2NSEeestPJmAF+0eBBqSZv/ZTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mu4q90TFZulF0fWPo4xFrM4h6BNrWqZLo4zhpLKC0SYurNLID0tKO8c7iGYrzX4uhr/BVOz9CqQVZee4jPWvUYEqr1wsJHoPGaXos5v4iCUXhapeKCxKbEzfPHe5DY25iza6UbVOLLQwxMyMzO8R1Z+ucUpxvT2TWnH80uxz12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tbnmr1qrvz6K7Fr;
	Fri, 16 Feb 2024 18:12:44 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 36144140A86;
	Fri, 16 Feb 2024 18:16:13 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 10:16:12 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 16 Feb 2024 10:16:12 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: RE: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Thread-Topic: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Thread-Index: AQHaHt2kLuqmPTjFUU+KA5oR6u/MrLEMQQ8AgAD0lxA=
Date: Fri, 16 Feb 2024 10:16:12 +0000
Message-ID: <f6c14302e3f74fdc9eef41857b534e63@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com> <Zc5cNLH9FS24qXTe@debian>
In-Reply-To: <Zc5cNLH9FS24qXTe@debian>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Fan,

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 15 February 2024 18:47
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
>fan.ni@samsung.com
>Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol sc=
rub
>control feature
>
>On Fri, Nov 24, 2023 at 09:53:36PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> control feature. The device patrol scrub proactively locates and makes
>> corrections to errors in regular cycle. The patrol scrub control
>> allows the request to configure patrol scrub input configurations.
>>
>> The patrol scrub control allows the requester to specify the number of
>> hours for which the patrol scrub cycles must be completed, provided
>> that the requested number is not less than the minimum number of hours
>> for the patrol scrub cycle that the device is capable of. In addition,
>> the patrol scrub controls allow the host to disable and enable the
>> feature in case disabling of the feature is needed for other purposes
>> such as performance-aware operations which require the background
>> operations to be turned off.
>>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>
>LGTM except for some minor comments inlined.
>
>
>>  hw/cxl/cxl-mailbox-utils.c | 97
>> +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 1bbc9a48a6..5a6f4e4029 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {  }
>> QEMU_PACKED CXLSupportedFeatureEntry;
>>
>>  enum CXL_SUPPORTED_FEATURES_LIST {
>> +    CXL_FEATURE_PATROL_SCRUB =3D 0,
>>      CXL_FEATURE_MAX
>>  };
>>
>> @@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>>  };
>>
>> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature
>> +*/ static const QemuUUID patrol_scrub_uuid =3D {
>> +    .data =3D UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
>> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a) };
>> +
>> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
>> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
>> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
>> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT
>BIT(1)
>> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
>> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
>> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
>> +
>> +/* CXL memdev patrol scrub control attributes */ struct
>> +CXLMemPatrolScrubReadAttrbs {
>> +        uint8_t scrub_cycle_cap;
>> +        uint16_t scrub_cycle;
>> +        uint8_t scrub_flags;
>> +} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
>> +
>> +typedef struct CXLMemPatrolScrubWriteAttrbs {
>> +    uint8_t scrub_cycle_hr;
>> +    uint8_t scrub_flags;
>> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
>> +
>> +typedef struct CXLMemPatrolScrubSetFeature {
>> +        CXLSetFeatureInHeader hdr;
>> +        CXLMemPatrolScrubWriteAttrbs feat_data; } QEMU_PACKED
>> +QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
>> +
>>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>> */  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
>*cmd,
>>                                               uint8_t *payload_in, @@
>> -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const
>struct cxl_cmd *cmd,
>>      uint16_t feat_entries =3D 0;
>>
>>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
>> +        get_feats_in->start_index >=3D CXL_FEATURE_MAX) {
>
>Not totally sure about this, the spec says "...Greater than..." although I=
 also think
>it should be >=3D. Similar things for the offset usage below.

Spec r3.1 described in Table 8-95. Get Supported Features Input Payload  as=
 ,=20
"Starting Feature Index: Index of the first requested Supported Feature Ent=
ry.
Feature index is a zero-based value."
Thus I believe get_feats_in->start_index >=3D CXL_FEATURE_MAX  is correct  =
because
the feature index is zero-based value.

Regarding the offset usage mentioned, can you point which code?
Is it get_feature->offset?=20

>
>Fan
>
>>          return CXL_MBOX_INVALID_INPUT;
>>      }
>>      req_entries =3D (get_feats_in->count - @@ -884,6 +916,31 @@ static
>> CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>>      entry =3D 0;
>>      while (entry < req_entries) {
>>          switch (index) {
>> +        case  CXL_FEATURE_PATROL_SCRUB:
>> +            /* Fill supported feature entry for device patrol scrub con=
trol */
>> +            get_feats_out->feat_entries[entry] =3D
>> +                           (struct CXLSupportedFeatureEntry) {
>> +                .uuid =3D patrol_scrub_uuid,
>> +                .feat_index =3D index,
>> +                .get_feat_size =3D sizeof(cxl_memdev_ps_feat_read_attrb=
s),
>> +                .set_feat_size =3D sizeof(CXLMemPatrolScrubWriteAttrbs)=
,
>> +                /* Bit[0] : 1, feature attributes changeable */
>> +                .attrb_flags =3D 0x1,
>> +                .get_feat_version =3D CXL_MEMDEV_PS_GET_FEATURE_VERSION=
,
>> +                .set_feat_version =3D CXL_MEMDEV_PS_SET_FEATURE_VERSION=
,
>> +                .set_feat_effects =3D 0,
>> +            };
>> +            feat_entries++;
>> +            /* Set default value for device patrol scrub read attribute=
s */
>> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =3D
>> +
>CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
>> +
>CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
>> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =3D
>> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT =
<< 8);
>> +            cxl_memdev_ps_feat_read_attrbs.scrub_flags =3D
>> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
>> +            break;
>>          default:
>>              break;
>>          }
>> @@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const
>struct cxl_cmd *cmd,
>>          return CXL_MBOX_INVALID_INPUT;
>>      }
>>
>> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
>> +        if (get_feature->offset >=3D sizeof(cxl_memdev_ps_feat_read_att=
rbs)) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        bytes_to_copy =3D sizeof(cxl_memdev_ps_feat_read_attrbs) -
>> +                                             get_feature->offset;
>> +        bytes_to_copy =3D (bytes_to_copy > get_feature->count) ?
>> +                               get_feature->count : bytes_to_copy;
>> +        memcpy(payload_out,
>> +               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
>> +               bytes_to_copy);
>> +    } else {
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +
>>      *len_out =3D bytes_to_copy;
>>
>>      return CXL_MBOX_SUCCESS;
>> @@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const
>struct cxl_cmd *cmd,
>>                                             size_t *len_out,
>>                                             CXLCCI *cci)  {
>> +    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
>> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
>> +    CXLSetFeatureInHeader *hdr =3D (void *)payload_in;
>> +
>> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>> +        if (hdr->version !=3D CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
>> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=3D
>> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER)=
 {
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +
>> +        ps_set_feature =3D (void *)payload_in;
>> +        ps_write_attrbs =3D &ps_set_feature->feat_data;
>> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &=3D ~0xFF;
>> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=3D
>> +                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
>> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags &=3D ~0x1;
>> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=3D
>> +                          ps_write_attrbs->scrub_flags & 0x1;
>> +    } else {
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> --
>> 2.34.1
>>

Thanks,
Shiju
