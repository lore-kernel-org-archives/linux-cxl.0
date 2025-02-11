Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13841C7F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739251306; cv=none; b=ku29EAGSCgnCEn6kHqyeVA5PKsY9NyRKEGUgRFNzggGgreVkP6Dc1+hZq8xRReQIXLtao1WxnXfq1CTfxdxOWYARZY0DeykYUat7ZZZmP4+FHyTCIvsnVxoNLxFN93YeZzyekwl0AqTI2eQjVeB8EzsuExCi/KqHO0hR56QFddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739251306; c=relaxed/simple;
	bh=JIke+vMXEMwP32yYijCuxe66sdZ1KI97LjgdelmS3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JEsf8wuaqcGzDgIeBXpNFQJoBOUAKpZpBBgsfK/jIga5j0qjC0j7t/P3WLgEGoRfuANh4bZjenlVk5j15imQKO25X0LkqINl9jPIbIaYentXRUtab5HT/3ay5+mp6geKEEMNLVifagZBNVKy4mY0z6D2Zu1UwVSJxaakLl20IyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ob1zhHPV; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ob1zhHPV"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250211052141epoutp03a22a699218002e63a2b7bce57aa78027~jD9fszLXI0284702847epoutp036
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 05:21:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250211052141epoutp03a22a699218002e63a2b7bce57aa78027~jD9fszLXI0284702847epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739251301;
	bh=4mSB4WrrvRi3s6FiC2tqJDVEyiCAPsVXt2n2CizDamw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ob1zhHPVzvjvRUz9EG23zSOBq0WUZGYJM3UeI8gszHy1Z008ugbdaGwLm9qgVn2cy
	 UQwm0J2cOIejcFKptqMghOizrC8xaWGNJdrM5JNK7onpBMXTWTJwUa4JDIzDwLtrzU
	 KiP7nWhRN3hD9m0IeXchgz/FgCdwc6+auke/4XbY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250211052140epcas5p3529915db2fe8a14787b709241a726eeb~jD9fbVNCY3171631716epcas5p3M;
	Tue, 11 Feb 2025 05:21:40 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YsVDM1PMRz4x9Q2; Tue, 11 Feb
	2025 05:21:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.68.19710.36EDAA76; Tue, 11 Feb 2025 14:21:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250211052057epcas5p4c04c1a47574ffca9a6cb2daaabe46634~jD825Bu2w2646426464epcas5p4N;
	Tue, 11 Feb 2025 05:20:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250211052057epsmtrp22c87f0a7e8cd2549b99b7a2258417bc8~jD824QPT12804228042epsmtrp26;
	Tue, 11 Feb 2025 05:20:57 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-94-67aade63f78d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.6E.18729.93EDAA76; Tue, 11 Feb 2025 14:20:57 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250211052055epsmtip1db735d6c58ace3b5ea9f2bec662f81f3~jD81V1J920163901639epsmtip17;
	Tue, 11 Feb 2025 05:20:55 +0000 (GMT)
Date: Tue, 11 Feb 2025 10:50:46 +0530
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, krish.reddy@samsung.com, vishak.g@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, s5.kumari@samsung.com,
	linux-cxl@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 1/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Message-ID: <20250211052046.nfcn2r7z3m376xh7@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250124145645.00005ba9@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmum7yvVXpBjcWsFlMP6xo8eX0HjaL
	mwd2MlmsWniNzWLhxmVMFudnnWKxON67g8VizbnPLEDuHHYHTo+WI29ZPZ5c28zk0bdlFaPH
	501yASxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
	QKcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyM
	TIEKE7IzOtd8Zyn4EVbx5sRc5gbGFbZdjJwcEgImEvdunmHvYuTiEBLYzSjR82wTlPOJUeLG
	0s0sEM43RolTf/4ywrQs77wAldjLKDH3ymVGuJZZe3cBORwcLAKqEs1X2UEa2AQMJB40Hwez
	RQSMJN7dmARWzyxwglFiy9SLrCAJYYEyial978E28Ao4SzQ8msgKYQtKnJz5hAVkJqeAocTG
	2RkgvRICX9kljvTvZwaJSwi4SMze7AdxnLDEq+Nb2CFsKYnP7/ayQdjFEucufoJ6oEbiddcK
	ZgjbXqL1VD+YzSyQIdGxcBtUvazE1FPrmCDifBK9v58wQcR5JXbMA7FB1qpILH2bCbPqy7Nm
	qPEeEutOroeGzwtGiavPXjJNYJSbheSbWUjWQdhWEp0fmlhnAY1lFpCWWP6PA8LUlFi/S38B
	I+sqRsnUguLc9NRk0wLDvNRyeBwn5+duYgQnTi2XHYw35v/TO8TIxMF4iFGCg1lJhNdk4Yp0
	Id6UxMqq1KL8+KLSnNTiQ4ymwNiZyCwlmpwPTN15JfGGJpYGJmZmZiaWxmaGSuK8zTtb0oUE
	0hNLUrNTUwtSi2D6mDg4pRqYnt5SzXl44mzjrHl5vqUqs+OipPK+KTUeyrs9sb6uSrT+cug1
	j/gdjuvDuFLehE0pvDTxk494mth6z/t3XvtzLlvafl7nzpEDfl7enb3nVptw99g3cXzefnlO
	uNnR9hLfjIrbqz9/WbbK0nnxjsh/a16tzxDc8EdLYT2n19r275bfdYrELp+S8G3KUZVPyebU
	28zn65r0VsZMmkn7O59z7Qlhyybzv+m9Kv8XOyyNu92YLW4zW1Bqa3QyY0zRUo/D6gmPy3rr
	M5lV9jskdZmqSaq8vsgkxHimQiQxSbr0JCfntVvR5selBH+v/5kXufKc7Y5ow21f2i5EmrmJ
	eznf3dfzvUJt4WN/Hq3/p5VYijMSDbWYi4oTAXF8AEwlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnK7lvVXpBj9n8VhMP6xo8eX0HjaL
	mwd2MlmsWniNzWLhxmVMFudnnWKxON67g8VizbnPLEDuHHYHTo+WI29ZPZ5c28zk0bdlFaPH
	501yASxRXDYpqTmZZalF+nYJXBmLJ35iLFgVUjHrYXgD4xerLkZODgkBE4nlnRdYuhi5OIQE
	djNKrLv5iwkiISVxbOdPNghbWGLlv+fsEEUfgIrmvwIq4uBgEVCVaL7KDlLDJmAg8aD5OJgt
	ImAk8e7GJEaQemaBU4wSHxf/BhskLFAmMbXvPSOIzSvgLNHwaCIrxNAXjBKXbxxhhUgISpyc
	+YQFxGYWMJOYt/khM8gyZgFpieX/OEBMTgFDiY2zMyYwCsxC0jALScMshIYFjMyrGCVTC4pz
	03OLDQsM81LL9YoTc4tL89L1kvNzNzGCA15Lcwfj9lUf9A4xMnEwHmKU4GBWEuE1WbgiXYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVANT6J7fF6dEhj8r
	MDlev/B+2TKtF3zLeu516ovq7930VSju+8HMDEmfQKapfmwGXbZn7xrwLX4QsPQcR2impswO
	lu7f6da7/Rbt91+4/cs54Z7dOzJ1jsWXmHIcr1eb9oV9cWDZScPojo2VnTNXtaTnXhF7FxAt
	rWcWdaBw8h6/K28O89rYzV9dNOP2kbBqY/0nK+/9yNz+1miHyT1uIUm5M33svdf1Nc0j1UOO
	ZYj+ZXzAdSpqUoCVWlib1XMTyUdtzj8ffCq06OvqXMftrPhzyRzfL6r6pUeN22SN+qw/rPd4
	ZHzm+r5gteLHV5ouvteJ0Xmc4BxRqeB0b9JWtu++eXuO8hyK+RMfrrawc6sSS3FGoqEWc1Fx
	IgDAWtSr5wIAAA==
X-CMS-MailID: 20250211052057epcas5p4c04c1a47574ffca9a6cb2daaabe46634
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_44a12_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050912epcas5p2965fd6efa702030802a42c225f11f65b
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050912epcas5p2965fd6efa702030802a42c225f11f65b@epcas5p2.samsung.com>
	<20250123050903.92336-2-vinayak.kh@samsung.com>
	<20250124145645.00005ba9@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_44a12_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/01/25 02:56PM, Jonathan Cameron wrote:
>On Thu, 23 Jan 2025 10:39:02 +0530
>Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>
>Hi Vinayak,
>
>Thanks for your patch!  Good to add support for this.
>
>Various comments inline, but all fairly minor things.
>
>thanks,
>
>Jonathan
>
>
>>     CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>>     CXL devices supports media operations discovery command.
>
>Please don't indent the commit message. Maybe this is a side effect
>of some tooling but definitely clean it up before sending a v2.
>
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>+CC linux-cxl to increase chance of review and let people know this
>exists.
>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 130 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..2315d07fb1 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -87,8 +87,9 @@ enum {
>>          #define GET_LSA       0x2
>>          #define SET_LSA       0x3
>>      SANITIZE    = 0x44,
>> -        #define OVERWRITE     0x0
>> -        #define SECURE_ERASE  0x1
>> +        #define OVERWRITE        0x0
>> +        #define SECURE_ERASE     0x1
>> +        #define MEDIA_OPERATIONS 0x2
>
>Trivial but I've given up trying to keep these aligned.
>It's a fools game as the names get steadily longer.
Ok Will Fix in V2
>
>As such better to just leave the existing pair alone.
>
>>      PERSISTENT_MEM = 0x45,
>>          #define GET_SECURITY_STATE     0x0
>>      MEDIA_AND_POISON = 0x43,
>> @@ -1721,6 +1722,127 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_BG_STARTED;
>>  }
>>
>> +enum {
>> +    MEDIA_OP_GENERAL  = 0x0,
>I'd name them so the field id explicit.
>
>MEDIA_OP_CLASS_GENERAL
>etc

Ok will fix in V2
>
>> +    MEDIA_OP_SANITIZE = 0x1,
>> +    MEDIA_OP_CLASS_MAX,
>No comma on terminating entry. We don't want it to be easy to add
>stuff after it.
>
>> +} MEDIA_OPERATION_CLASS;
>The enum type is never used.  So might as well keep it anonymous
>like we do for other enums in this file.
>
>> +
>> +enum {
>> +    MEDIA_OP_SUB_DISCOVERY = 0x0,
>This set of class and subcalss is similar to the enum you add
>the MEDIA_OPERATIONS define to above.
>I'd take a similar strategy with
>
ok will fix
>enum {
>    MEDIA_OP_CLASS_GENERAL = 0x0,
>        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
>    MEDIA_OP_CLASS_SANITIZE = 0x1,
>        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
>        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
>
>or something like that.
ok will fix 
>}
>> +    MEDIA_OP_SUB_SANITIZE = 0x0,
>> +    MEDIA_OP_SUB_ZERO     = 0x1,
>> +    MEDIA_OP_SUB_CLASS_MAX
>No need for SUB_CLASS_MAX as you don't seem to use it.
>
>> +} MEDIA_OPERATION_SUB_CLASS;
>> +
>> +struct media_op_supported_list_entry {
>> +    uint8_t media_op_class;
>> +    uint8_t media_op_subclass;
>> +};
>> +
>> +struct media_op_discovery_out_pl {
>> +    uint64_t dpa_range_granularity;
>> +    uint16_t total_supported_operations;
>> +    uint16_t num_of_supported_operations;
>> +    struct media_op_supported_list_entry entry[0];
>entry[]
ok will change it in V2
>
>which is the c spec defined way to do variable length last elements.
>The [0] was I think a weird extension that we have moved away from.
>
>> +};
>
>Not strictly necessary but I'd mark it packed as chances of future breakage
>are high with a structure starting at byte 0xC.
>
ok will fix
>> +
>> +#define MAX_SUPPORTED_OPS 3
>I'd avoid explicit define for this and just use ARRAY_SIZE() on the
>array of structures to find out.
>
>> +struct media_op_supported_list_entry media_op_matrix[MAX_SUPPORTED_OPS] = {
>
>Use the defines above rather than the numeric values.
>Then it's obvious what this is, also mark it static const.
>
ok will fix 
>static const struct media_op_supported_list_entry media_op_matrix[] =
>    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
>    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
>    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
>};
>
>> +                                                            {0, 0},
>> +                                                            {1, 0},
>> +                                                            {1, 1} };
>> +
>> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>> +                                         uint8_t *payload_in,
>> +                                         size_t len_in,
>> +                                         uint8_t *payload_out,
>> +                                         size_t *len_out,
>> +                                         CXLCCI *cci)
>> +{
>> +    struct {
>> +    uint8_t media_operation_class;
>    struct {
>        uint8_t media_operation_class;
>
>etc for alignment.
>
>> +    uint8_t media_operation_subclass;
>> +    uint8_t rsvd[2];
>> +    uint32_t dpa_range_count;
>> +    union {
>> +        struct {
>> +            uint64_t starting_dpa;
>> +            uint64_t length;
>> +        } dpa_range_list[0];
>[]
here its under union, compiler errors if not 
given the [0] number of element.
May be try some other way
>
>> +        struct {
>> +            uint16_t start_index;
>> +            uint16_t num_supported_ops;
>> +        } discovery_osa;
>> +    };
>
>This is a little tricky as in theory you can have a variable number
>of DPA Range List elements and then the operation specific arguments.
>
>However, general always provides a range count of 0.  Also both sanitize
>and zero have no osa elemetns.  Add a comment
>about this so we don't think it looks wrong in future + do notice that
>this approach doesn't generalize if a new operation allows dpa ranges
>and operation specific parameters.
>
Will add approriate comment
>
>> +    } QEMU_PACKED *media_op_in_pl = (void *)payload_in;
>> +
>> +    uint8_t media_op_cl = media_op_in_pl->media_operation_class;
>> +    uint8_t media_op_subclass = media_op_in_pl->media_operation_subclass;
>> +    uint32_t dpa_range_count = media_op_in_pl->dpa_range_count;
>> +
>> +    if (len_in < sizeof(*media_op_in_pl)) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>
>Test this before getting values to fill in media_op_cl local variables etc.
>It's both logically correct and may constrain the compiler not to get too smart
>if it can see enough to realize what len_in is.
>
ok 
>> +
>> +    switch (media_op_cl) {
>> +    case MEDIA_OP_GENERAL:
>> +        switch (media_op_subclass) {
>> +        case MEDIA_OP_SUB_DISCOVERY:
>Given there is only one element, maybe cleaner as
>           if (media_op_subclass != MEDIA_OP_SUB_DISCOVERY) {
>                return CXL_MBOX_UNSUPPORTED;
>           }
>AS reduces indent of the following, helping readability a litle.
ok
>
>> +            int count = 0;
>> +            struct media_op_discovery_out_pl *media_out_pl =
>> +                (void *)payload_out;
>> +            int num_ops = media_op_in_pl->discovery_osa.num_supported_ops;
>> +            int start_index = media_op_in_pl->discovery_osa.start_index;
>> +
>> +            /* As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count */
>> +            /* should be zero for discovery sub class command */
>Local style is multiline comment as
>               /*
>                * As per spec CXL 3.1...
>                * should be zero...
>                */
>

ok
>> +            if (dpa_range_count) {
>> +                return CXL_MBOX_INVALID_INPUT;
>> +            }
>> +
>> +            if ((start_index >= MEDIA_OP_CLASS_MAX) ||
>> +                (num_ops > MAX_SUPPORTED_OPS)) {
>
>Check here should be for num_ops + start_index > MAX_SUPPORTED OPS
>Comparing start_index against MEDIA_OP_CLASS_MAX doesn't make sense to me
>as I believe it's an index into the array of Class / subclass pairs not
>the class array.
>

ok
>
>> +                return CXL_MBOX_INVALID_INPUT;
>> +            }
>> +
>> +            media_out_pl->dpa_range_granularity = CXL_CAPACITY_MULTIPLIER;
>> +            media_out_pl->total_supported_operations = MAX_SUPPORTED_OPS;
>> +            if (num_ops > 0) {
>> +                for (int i = start_index; i < MAX_SUPPORTED_OPS; i++) {
>> +                    media_out_pl->entry[count].media_op_class =
>> +                            media_op_matrix[i].media_op_class;
>> +                    media_out_pl->entry[count].media_op_subclass =
>> +                            media_op_matrix[i].media_op_subclass;
>> +                    count++;
>> +                    if (count == num_ops) {
>> +                        goto disc_out;
>
>break should be enough and removes need for goto and label.
>

ok
>> +                    }
>> +                }
>> +            }
>> +disc_out:
>> +            media_out_pl->num_of_supported_operations = count;
>> +            *len_out = sizeof(struct media_op_discovery_out_pl) +
>> +            (sizeof(struct media_op_supported_list_entry) * count);
>
>indent this line.
>

ok
>> +            break;
>I'd
>        return CXL_MBOX_SUCCESS;
>
>> +        default:
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +        break;
>then this break isn't needed.

ok
>> +    case MEDIA_OP_SANITIZE:
>> +        switch (media_op_subclass) {
>> +
>No blank line here yet.
>> +        default:
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>Similar. Return in all paths so no break.

ok
>> +        break;
>> +    default:
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
>>                                           uint8_t *payload_in,
>>                                           size_t len_in,
>> @@ -2864,6 +2986,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>           CXL_MBOX_SECURITY_STATE_CHANGE |
>>           CXL_MBOX_BACKGROUND_OPERATION |
>>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
>> +    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
>> +        ~0,
>> +        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>> +         CXL_MBOX_BACKGROUND_OPERATION)},
>>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>>          cmd_get_security_state, 0, 0 },
>>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_44a12_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_44a12_--
