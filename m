Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAAB116
	for <linux-cxl@vger.kernel.org>; Tue, 21 Nov 2023 02:32:53 -0800 (PST)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZLFP0ZXsz6K5xM;
	Tue, 21 Nov 2023 18:28:41 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:32:50 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Tue, 21 Nov 2023 10:32:50 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>
Subject: RE: [RFC PATCH 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Thread-Topic: [RFC PATCH 1/3] hw/cxl/cxl-mailbox-utils: Add support for
 feature commands (8.2.9.6)
Thread-Index: AQHaFviya+dtfOI5Ykuwxyme/BxmpLCDphCAgAD1RYA=
Date: Tue, 21 Nov 2023 10:32:50 +0000
Message-ID: <6d1e66271e6142f88afc17cd6673a00b@huawei.com>
References: <20231114124711.1128-1-shiju.jose@huawei.com>
 <20231114124711.1128-2-shiju.jose@huawei.com>
 <37bcqgzeu2x573n5sbec3snqekbfkgkd7zmczxr4rb2mn7jpgw@nxxhbjpkup2k>
In-Reply-To: <37bcqgzeu2x573n5sbec3snqekbfkgkd7zmczxr4rb2mn7jpgw@nxxhbjpkup2k>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.126.175.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected

Hi Davidlohr,

Thanks for reviewing and for the comments.

>-----Original Message-----
>From: Davidlohr Bueso <dave@stgolabs.net>
>Sent: 20 November 2023 19:45
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
>fan.ni@samsung.com; a.manzanares@samsung.com
>Subject: Re: [RFC PATCH 1/3] hw/cxl/cxl-mailbox-utils: Add support for fea=
ture
>commands (8.2.9.6)
>
>On Tue, 14 Nov 2023, shiju.jose@huawei.com wrote:
>
>>From: Shiju Jose <shiju.jose@huawei.com>
>>
>>CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
>>CXL devices supports features with changeable attributes.
>>Get Supported Features retrieves the list of supported device specific
>>features. The settings of a feature can be retrieved using Get Feature
>>and optionally modified using Set Feature.
>>
>>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
>... with some comments below.
>
>>---
>> hw/cxl/cxl-mailbox-utils.c | 140 +++++++++++++++++++++++++++++++++++++
>> 1 file changed, 140 insertions(+)
>>
>>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>>index 6184f44339..93960afd44 100644
>>--- a/hw/cxl/cxl-mailbox-utils.c
>>+++ b/hw/cxl/cxl-mailbox-utils.c
>>@@ -66,6 +66,10 @@ enum {
>>     LOGS        =3D 0x04,
>>         #define GET_SUPPORTED 0x0
>>         #define GET_LOG       0x1
>>+    FEATURES    =3D 0x05,
>>+        #define GET_SUPPORTED 0x0
>>+        #define GET_FEATURE   0x1
>>+        #define SET_FEATURE   0x2
>>     IDENTIFY    =3D 0x40,
>>         #define MEMORY_DEVICE 0x0
>>     CCLS        =3D 0x41,
>>@@ -785,6 +789,135 @@ static CXLRetCode cmd_logs_get_log(const struct
>cxl_cmd *cmd,
>>     return CXL_MBOX_SUCCESS;
>> }
>>
>>+/* CXL r3.0 section 8.2.9.6: Features */ typedef struct
>>+CXLSupportedFeatureHeader {
>>+    uint16_t entries;
>>+    uint16_t nsuppfeats_dev;
>>+    uint32_t reserved;
>>+} QEMU_PACKED CXLSupportedFeatureHeader;
>>+
>>+typedef struct CXLSupportedFeatureEntry {
>>+    QemuUUID uuid;
>>+    uint16_t feat_index;
>>+    uint16_t get_feat_size;
>>+    uint16_t set_feat_size;
>>+    uint32_t attrb_flags;
>>+    uint8_t get_feat_version;
>>+    uint8_t set_feat_version;
>>+    uint16_t set_feat_effects;
>>+    uint8_t rsvd[18];
>>+} QEMU_PACKED CXLSupportedFeatureEntry;
>>+
>>+enum CXL_SUPPORTED_FEATURES_LIST {
>>+    CXL_FEATURE_MAX
>>+};
>>+
>>+typedef struct CXLSetFeatureInHeader {
>>+        QemuUUID uuid;
>>+        uint32_t flags;
>>+        uint16_t offset;
>>+        uint8_t version;
>>+        uint8_t rsvd[9];
>>+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
>>+
>>+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
>>+#define CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER    0
>>+#define CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER    1
>>+#define CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER    2
>>+#define CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER    3
>>+#define CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER    4
>
>Maybe enum here?
Sure. I will change.

>
>>+
>>+/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>>+*/ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
>*cmd,
>>+                                             uint8_t *payload_in,
>>+                                             size_t len_in,
>>+                                             uint8_t *payload_out,
>>+                                             size_t *len_out,
>>+                                             CXLCCI *cci) {
>>+    struct {
>>+        uint32_t count;
>>+        uint16_t start_index;
>>+        uint16_t reserved;
>>+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in =3D (void
>>+*)payload_in;
>>+
>>+    struct {
>>+        CXLSupportedFeatureHeader hdr;
>>+        CXLSupportedFeatureEntry feat_entries[];
>>+    } QEMU_PACKED QEMU_ALIGNED(16) * supported_feats =3D (void
>>+ *)payload_out;
>
>s/supported_feats/get_feats_out.
Will change.

>
>>+    uint16_t index;
>>+    uint16_t entry, req_entries;
>>+    uint16_t feat_entries =3D 0;
>>+
>>+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>>+        get_feats_in->start_index > CXL_FEATURE_MAX) {
>
>Ah I see you update this to '>=3D' in the next patch.
>
>>+        return CXL_MBOX_INVALID_INPUT;
>>+    } else {
>
>This branch is not needed.
Ok.

>
>>+        req_entries =3D (get_feats_in->count -
>>+                        sizeof(CXLSupportedFeatureHeader)) /
>>+                        sizeof(CXLSupportedFeatureEntry);
>>+    }
>>+    if (req_entries > CXL_FEATURE_MAX) {
>>+        req_entries =3D CXL_FEATURE_MAX;
>>+    }
>
>min()?
Sure.

>
>>+    supported_feats->hdr.nsuppfeats_dev =3D CXL_FEATURE_MAX;
>
>Logically this should go below, when setting the feature entries.
>
>>+    index =3D get_feats_in->start_index;
>>+
>>+    entry =3D 0;
>>+    while (entry < req_entries) {
>>+        switch (index) {
>>+        default:
>>+            break;
>>+        }
>>+        index++;
>>+        entry++;
>>+    }
>>+
>>+    supported_feats->hdr.entries =3D feat_entries;
>>+    *len_out =3D sizeof(CXLSupportedFeatureHeader) +
>>+                      feat_entries * sizeof(CXLSupportedFeatureEntry);
>>+
>>+    return CXL_MBOX_SUCCESS;
>>+}
>>+
>>+/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */ static
>>+CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>>+                                           uint8_t *payload_in,
>>+                                           size_t len_in,
>>+                                           uint8_t *payload_out,
>>+                                           size_t *len_out,
>>+                                           CXLCCI *cci) {
>>+    struct {
>>+        QemuUUID uuid;
>>+        uint16_t offset;
>>+        uint16_t count;
>>+        uint8_t selection;
>>+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
>>+    uint16_t bytes_to_copy =3D 0;
>>+
>>+    get_feature =3D (void *)payload_in;
>>+
>>+    if (get_feature->offset + get_feature->count > cci->payload_max) {
>>+        return CXL_MBOX_INVALID_INPUT;
>>+    }
>
>For now maybe return unsupported if a non-zero selection is passed?
Sure.

>
>>+
>>+    *len_out =3D bytes_to_copy;
>>+
>>+    return CXL_MBOX_SUCCESS;
>>+}
>>+
>>+/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */ static
>>+CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>>+                                           uint8_t *payload_in,
>>+                                           size_t len_in,
>>+                                           uint8_t *payload_out,
>>+                                           size_t *len_out,
>>+                                           CXLCCI *cci) {
>>+    return CXL_MBOX_SUCCESS;
>>+}
>>+
>> /* 8.2.9.5.1.1 */
>> static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>>                                              uint8_t *payload_in, @@
>>-1954,6 +2087,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =3D=
 {
>>     [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED",
>cmd_logs_get_supported,
>>                               0, 0 },
>>     [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>>+    [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
>>+                                  cmd_features_get_supported, 0x8, 0 },
>>+    [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
>>+                                cmd_features_get_feature, 0x15, 0 },
>>+    [FEATURES][SET_FEATURE] =3D { "FEATURES_SET_FEATURE",
>>+                                cmd_features_set_feature,
>>+                                ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE
>>+ },
>
>I don't think we are actually doing anything with these, but in addition t=
o the
>config, set_feature would need IMMEDIATE_DATA_CHANGE,
>IMMEDIATE_POLICY_CHANGE, IMMEDIATE_LOG_CHANGE and
>SECURITY_STATE_CHANGE.
Sure. I will change.

>
>>     [IDENTIFY][MEMORY_DEVICE] =3D { "IDENTIFY_MEMORY_DEVICE",
>>         cmd_identify_memory_device, 0, 0 },
>>     [CCLS][GET_PARTITION_INFO] =3D { "CCLS_GET_PARTITION_INFO",
>>--
>>2.34.1
>>

Thanks,
Shiju
