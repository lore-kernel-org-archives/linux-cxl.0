Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3D1AAA5
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075260; cv=none; b=u3ixXMp7woob/rJmpYlXzw3v4PbO/pydQEM+TeM7d6ub+2IEd/5ay7fFUNt7IZM+48ELldN++CXXb2xDuNeqUfUUlY8uCyCwTjrShR9xGmGgn0XiZSh9XlVIn8Wbd6LHjWGsPMO8tCDBJLj0H9QOOuk8WJSCvMGmG+wSCHROio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075260; c=relaxed/simple;
	bh=UPTyttrspqqNoKrBCJ7yFu6PlkcEeHzKLgB3IXJpEp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRrnvpEnNNRahe9CUQgTFaq0h7qNFryx92QgcaxNrfUxnx/6uqgsu2ua1eYzFyP33f9SzPwNolqK1qNbj5rPVYhA3cjGg4dpymkz24EiYlJvu1DkwudsqC6/3OijGMc8vSi4sKWiuNJI+NuDIdmssui5R5aHVoPURHuVkcurGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbmXy48Dtz6K7G7;
	Fri, 16 Feb 2024 17:17:22 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id 70CA4140B63;
	Fri, 16 Feb 2024 17:20:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:20:51 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 16 Feb 2024 09:20:51 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Thread-Topic: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Thread-Index: AQHaHt2k9HtibX8fzEeC6ibsAHGqnrEMNWYAgAD/BkA=
Date: Fri, 16 Feb 2024 09:20:50 +0000
Message-ID: <e773c12ca6ca40a1aa582d3a8a4043d9@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-2-shiju.jose@huawei.com> <Zc5SbEn1J-Bk0tYg@debian>
In-Reply-To: <Zc5SbEn1J-Bk0tYg@debian>
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

Thanks for the feedbacks.

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 15 February 2024 18:06
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feat=
ure
>commands (8.2.9.6)
>
>On Fri, Nov 24, 2023 at 09:53:35PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.0 section 8.2.9.6 describes optional device specific features=
.
>> CXL devices supports features with changeable attributes.
>> Get Supported Features retrieves the list of supported device specific
>> features. The settings of a feature can be retrieved using Get Feature
>> and optionally modified using Set Feature.
>>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>
>Updated the references to align with cxl spec r3.1, other than that looks =
good to
>me.

I had posted v3 of this series updated for spec r3.1. Please find here,
https://lore.kernel.org/qemu-devel/20240215110146.1444-1-shiju.jose@huawei.=
com/T/#t

>
>Fan
>
>>  hw/cxl/cxl-mailbox-utils.c | 167
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 167 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 6184f44339..1bbc9a48a6 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -66,6 +66,10 @@ enum {
>>      LOGS        =3D 0x04,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_LOG       0x1
>> +    FEATURES    =3D 0x05,
>> +        #define GET_SUPPORTED 0x0
>> +        #define GET_FEATURE   0x1
>> +        #define SET_FEATURE   0x2
>>      IDENTIFY    =3D 0x40,
>>          #define MEMORY_DEVICE 0x0
>>      CCLS        =3D 0x41,
>> @@ -785,6 +789,157 @@ static CXLRetCode cmd_logs_get_log(const struct
>cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.0 section 8.2.9.6: Features */ typedef struct
>> +CXLSupportedFeatureHeader {
>> +    uint16_t entries;
>> +    uint16_t nsuppfeats_dev;
>> +    uint32_t reserved;
>> +} QEMU_PACKED CXLSupportedFeatureHeader;
>> +
>> +typedef struct CXLSupportedFeatureEntry {
>> +    QemuUUID uuid;
>> +    uint16_t feat_index;
>> +    uint16_t get_feat_size;
>> +    uint16_t set_feat_size;
>> +    uint32_t attrb_flags;
>> +    uint8_t get_feat_version;
>> +    uint8_t set_feat_version;
>> +    uint16_t set_feat_effects;
>> +    uint8_t rsvd[18];
>> +} QEMU_PACKED CXLSupportedFeatureEntry;
>> +
>> +enum CXL_SUPPORTED_FEATURES_LIST {
>> +    CXL_FEATURE_MAX
>> +};
>> +
>> +/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
>> +/*
>> + * Get Feature input payload
>> + * CXL rev 3.0 section 8.2.9.6.2; Table 8-79  */
>> +/* Get Feature : Payload in selection */ enum
>> +CXL_GET_FEATURE_SELECTION {
>> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE =3D 0x0,
>> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE =3D 0x1,
>> +    CXL_GET_FEATURE_SEL_SAVED_VALUE =3D 0x2,
>> +    CXL_GET_FEATURE_SEL_MAX
>> +};
>> +
>> +/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
>> +/*
>> + * Set Feature input payload
>> + * CXL rev 3.0 section 8.2.9.6.3; Table 8-81  */ typedef struct
>> +CXLSetFeatureInHeader {
>> +        QemuUUID uuid;
>> +        uint32_t flags;
>> +        uint16_t offset;
>> +        uint8_t version;
>> +        uint8_t rsvd[9];
>> +} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
>> +
>> +/* Set Feature : Payload in flags */
>> +#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
>> +enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER =3D 0x0,
>> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER =3D 0x1,
>> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER =3D 0x2,
>> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER =3D 0x3,
>> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER =3D 0x4,
>> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>> +};
>> +
>> +/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>> +*/ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
>*cmd,
>> +                                             uint8_t *payload_in,
>> +                                             size_t len_in,
>> +                                             uint8_t *payload_out,
>> +                                             size_t *len_out,
>> +                                             CXLCCI *cci) {
>> +    struct {
>> +        uint32_t count;
>> +        uint16_t start_index;
>> +        uint16_t reserved;
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in =3D (void
>> +*)payload_in;
>> +
>> +    struct {
>> +        CXLSupportedFeatureHeader hdr;
>> +        CXLSupportedFeatureEntry feat_entries[];
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out =3D (void
>*)payload_out;
>> +    uint16_t index;
>> +    uint16_t entry, req_entries;
>> +    uint16_t feat_entries =3D 0;
>> +
>> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +    req_entries =3D (get_feats_in->count -
>> +                   sizeof(CXLSupportedFeatureHeader)) /
>> +                   sizeof(CXLSupportedFeatureEntry);
>> +    req_entries =3D MIN(req_entries, CXL_FEATURE_MAX);
>> +    index =3D get_feats_in->start_index;
>> +
>> +    entry =3D 0;
>> +    while (entry < req_entries) {
>> +        switch (index) {
>> +        default:
>> +            break;
>> +        }
>> +        index++;
>> +        entry++;
>> +    }
>> +
>> +    get_feats_out->hdr.nsuppfeats_dev =3D CXL_FEATURE_MAX;
>> +    get_feats_out->hdr.entries =3D feat_entries;
>> +    *len_out =3D sizeof(CXLSupportedFeatureHeader) +
>> +                      feat_entries *
>> + sizeof(CXLSupportedFeatureEntry);
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */ static
>> +CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>> +                                           uint8_t *payload_in,
>> +                                           size_t len_in,
>> +                                           uint8_t *payload_out,
>> +                                           size_t *len_out,
>> +                                           CXLCCI *cci) {
>> +    struct {
>> +        QemuUUID uuid;
>> +        uint16_t offset;
>> +        uint16_t count;
>> +        uint8_t selection;
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
>> +    uint16_t bytes_to_copy =3D 0;
>> +
>> +    get_feature =3D (void *)payload_in;
>> +
>> +    if (get_feature->selection !=3D CXL_GET_FEATURE_SEL_CURRENT_VALUE) =
{
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +    if (get_feature->offset + get_feature->count > cci->payload_max) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    *len_out =3D bytes_to_copy;
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */ static
>> +CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>> +                                           uint8_t *payload_in,
>> +                                           size_t len_in,
>> +                                           uint8_t *payload_out,
>> +                                           size_t *len_out,
>> +                                           CXLCCI *cci) {
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* 8.2.9.5.1.1 */
>>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>>                                               uint8_t *payload_in, @@
>> -1954,6 +2109,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>>      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED",
>cmd_logs_get_supported,
>>                                0, 0 },
>>      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>> +    [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
>> +                                  cmd_features_get_supported, 0x8, 0 },
>> +    [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
>> +                                cmd_features_get_feature, 0x15, 0 },
>> +    [FEATURES][SET_FEATURE] =3D { "FEATURES_SET_FEATURE",
>> +                                cmd_features_set_feature,
>> +                                ~0,
>> +                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
>> +                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
>>      [IDENTIFY][MEMORY_DEVICE] =3D { "IDENTIFY_MEMORY_DEVICE",
>>          cmd_identify_memory_device, 0, 0 },
>>      [CCLS][GET_PARTITION_INFO] =3D { "CCLS_GET_PARTITION_INFO",
>> --
>> 2.34.1
>>

Thanks,
Shiju
