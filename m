Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011D446BD
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364806; cv=none; b=n2W9sUsudpfFYPwx2o3y2idbzjJ3Dg4j92ziemTYA0u+lEsv+dcQ10Tt4Wjwkbn26q4sEIpQl4xzhEj9TtH9anUgA9GSElK1hi1VZGOcXTD0UZovyxpQbIFJGGrGk/QXw11SC7trGQ0Bh+Xxv9peLwgQm4fGe3STgRBEqQhCBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364806; c=relaxed/simple;
	bh=gMMC+2re6yGStJs8/6Nl4L6u5K/oQXHjfmDR3YQOAso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5rv/gEJee0Gy5PhvuxsDOQyX8TQOz9lWDyRkuZsnBvxemamFu+l2ijO5KbfiSfKc3/8I22vajSG31JXTKEbOvqiuHVC2FsILQ6sfspHmFOPXpuHRHyN/7yxZUJr/9RieWDyWzyYgCuTb4DEADrL9Fz5oRUBBXjZB2QpwkcMlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdqd76s9vz67G9M;
	Tue, 20 Feb 2024 01:43:07 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 706DA1404FC;
	Tue, 20 Feb 2024 01:46:41 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:46:41 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Mon, 19 Feb 2024 17:46:41 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v4 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Thread-Topic: [PATCH v4 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Thread-Index: AQHaY0RpBuXGGv7onE+ApsS5f2IfM7ER43WAgAAK9pA=
Date: Mon, 19 Feb 2024 17:46:40 +0000
Message-ID: <f52ee7526af14f3596081af40e953ec8@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
	<20240219150025.1531-4-shiju.jose@huawei.com>
 <20240219165927.00006fd8@Huawei.com>
In-Reply-To: <20240219165927.00006fd8@Huawei.com>
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

Hi Jonathan,

Thanks for the feedbacks.

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 19 February 2024 16:59
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH v4 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
>control feature
>
>On Mon, 19 Feb 2024 23:00:25 +0800
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub
>> (ECS) control feature.
>>
>> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
>> Specification (JESD79-5) and allows the DRAM to internally read,
>> correct single-bit errors, and write back corrected data bits to the
>> DRAM array while providing transparency to error counts. The ECS
>> control feature allows the request to configure ECS input
>> configurations during system boot or at run-time.
>>
>> The ECS control allows the requester to change the log entry type, the
>> ECS threshold count provided that the request is within the definition
>> specified in DDR5 mode registers, change mode between codeword mode
>> and row count mode, and reset the ECS counter.
>>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Same thing about it being per device, not global.
Sure.  I will check this.

>
>Otherwise, just a few minor comments inline.
>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 100
>> ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 99 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 908ce16642..2277418c07 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -998,6 +998,7 @@ typedef struct CXLSupportedFeatureEntry {
>>
>>  enum CXL_SUPPORTED_FEATURES_LIST {
>>      CXL_FEATURE_PATROL_SCRUB =3D 0,
>> +    CXL_FEATURE_ECS,
>>      CXL_FEATURE_MAX
>>  };
>>
>> @@ -1070,6 +1071,43 @@ typedef struct CXLMemPatrolScrubSetFeature {  }
>> QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;  static
>> CXLMemPatrolScrubReadAttrs cxl_memdev_ps_feat_attrs;
>>
>> +/*
>> + * CXL r3.1 section 8.2.9.9.11.2:
>> + * DDR5 Error Check Scrub (ECS) Control Feature  */ static const
>> +QemuUUID ecs_uuid =3D {
>> +    .data =3D UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
>> +                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86) };
>> +
>> +#define CXL_ECS_GET_FEATURE_VERSION    0x01
>> +#define CXL_ECS_SET_FEATURE_VERSION    0x01
>> +#define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
>> +#define CXL_ECS_REALTIME_REPORT_CAP_DEFAULT    1
>> +#define CXL_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5:
>4096 */
>> +#define CXL_ECS_MODE_DEFAULT    0
>> +
>> +#define CXL_ECS_NUM_MEDIA_FRUS   3
>> +
>> +/* CXL memdev DDR5 ECS control attributes */ typedef struct
>> +CXLMemECSReadAttrs {
>> +        uint8_t ecs_log_cap;
>> +        uint8_t ecs_cap;
>> +        uint16_t ecs_config;
>> +        uint8_t ecs_flags;
>> +} QEMU_PACKED CXLMemECSReadAttrs;
>> +
>> +typedef struct CXLMemECSWriteAttrs {
>> +    uint8_t ecs_log_cap;
>> +    uint16_t ecs_config;
>> +} QEMU_PACKED CXLMemECSWriteAttrs;
>> +
>> +typedef struct CXLMemECSSetFeature {
>> +        CXLSetFeatureInHeader hdr;
>> +        CXLMemECSWriteAttrs feat_data[]; } QEMU_PACKED
>> +QEMU_ALIGNED(16) CXLMemECSSetFeature; static CXLMemECSReadAttrs
>> +cxl_ecs_feat_attrs[CXL_ECS_NUM_MEDIA_FRUS];
>
>This should be device instance specific.
Ok.

>
>> +
>>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>> */  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
>*cmd,
>>                                               uint8_t *payload_in, @@
>> -1088,7 +1126,7 @@ static CXLRetCode cmd_features_get_supported(const
>struct cxl_cmd *cmd,
>>          CXLSupportedFeatureHeader hdr;
>>          CXLSupportedFeatureEntry feat_entries[];
>>      } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out =3D (void
>*)payload_out;
>> -    uint16_t index;
>> +    uint16_t count, index;
>>      uint16_t entry, req_entries;
>>      uint16_t feat_entries =3D 0;
>>
>> @@ -1130,6 +1168,35 @@ static CXLRetCode
>cmd_features_get_supported(const struct cxl_cmd *cmd,
>>              cxl_memdev_ps_feat_attrs.scrub_flags =3D
>>                                  CXL_MEMDEV_PS_ENABLE_DEFAULT;
>>              break;
>> +        case  CXL_FEATURE_ECS:
>> +            /* Fill supported feature entry for device DDR5 ECS control=
 */
>> +            get_feats_out->feat_entries[entry] =3D
>> +                         (struct CXLSupportedFeatureEntry) {
>> +                .uuid =3D ecs_uuid,
>> +                .feat_index =3D index,
>> +                .get_feat_size =3D CXL_ECS_NUM_MEDIA_FRUS *
>> +                                    sizeof(CXLMemECSReadAttrs),
>> +                .set_feat_size =3D CXL_ECS_NUM_MEDIA_FRUS *
>> +                                    sizeof(CXLMemECSWriteAttrs),
>> +                .attr_flags =3D 0x1,
>> +                .get_feat_version =3D CXL_ECS_GET_FEATURE_VERSION,
>> +                .set_feat_version =3D CXL_ECS_SET_FEATURE_VERSION,
>> +                .set_feat_effects =3D 0,
>I think spec says Immediate config change for this one.Plus the CEL bit sh=
ould be
>set (bit 9)
Sure. I will change.=20
=20
>
>Check this for the other features as well.
>
>> +            };
>> +            feat_entries++;
>
>Why update this mid setting up the record?  I briefly thought this wrote t=
wo
>different records (which was odd!)
>
>We don't have gaps in the features - we probably won't ever provide that d=
egree
>of control of the QEMU model, so feat_entries will be req_entries -
>get_feats_in->start_index No need to keep a count.
Yes. You are right.

>
>> +            /* Set default value for DDR5 ECS read attributes */
>> +            for (count =3D 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) =
{
>> +                cxl_ecs_feat_attrs[count].ecs_log_cap =3D
>> +                                    CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
>> +                cxl_ecs_feat_attrs[count].ecs_cap =3D
>> +                                    CXL_ECS_REALTIME_REPORT_CAP_DEFAULT=
;
>> +                cxl_ecs_feat_attrs[count].ecs_config =3D
>> +                                    CXL_ECS_THRESHOLD_COUNT_DEFAULT |
>> +                                    (CXL_ECS_MODE_DEFAULT << 3);
>> +                /* Reserved */
>> +                cxl_ecs_feat_attrs[count].ecs_flags =3D 0;
>> +            }
>> +            break;
>>          default:
>>              break;
>>          }

Thanks,
Shiju
