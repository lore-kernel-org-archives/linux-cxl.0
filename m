Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7A221462
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746853; cv=none; b=VhbGSdF4XKdt0dV4YF/8ehoT7PojA2Nm5C5oVZGMHI2qELxWtDovm5TU+HM9UwIHXy8tLyEDhUk9CoNVwZ3LR5PYJpANv6+W5MqGM7WG8vFZ2IIrmcNtIFYGzWjnEG6jsz2av4iYaY5Wqpm4W3mJP0jZZ4mMQOw1s5TuAtq2ULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746853; c=relaxed/simple;
	bh=eQXq2G4gMxjzTKEeKwTnLLqDGSqu4d/eIC8DYoVkTDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsrY5X+N6XORnX1NmBoLH3TRofK2WsaKhvg5qf/2KyYbjZVuo9toY0Xcpd89GXhnWbtDh5+jBAcNjut9LbQ3RoUIvFwEd/pwVLR0roltOzeQOn5Vhg4zQIUv6p74qpX5gtaPYfT1n3DREcKRc7+bpONbMzj7Nfh48EyExXL9KTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6LSK6G3gz6GC7Z;
	Mon,  9 Dec 2024 20:16:17 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id C1F2D140A30;
	Mon,  9 Dec 2024 20:20:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 13:20:43 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 9 Dec 2024 13:20:43 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Index: AQHbN6U//ktgkagc00iV+8Wv/2ktBLLYb+oAgAWC9mA=
Date: Mon, 9 Dec 2024 12:20:43 +0000
Message-ID: <fa75124b8071441b8daa66d474b5bec1@huawei.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-5-dave.jiang@intel.com>
 <675248e44c037_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <675248e44c037_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
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

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2024 00:44
>To: Dave Jiang <dave.jiang@intel.com>; linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>
>Subject: Re: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox
>command
>
>Dave Jiang wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for GET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> The settings of a feature can be retrieved using Get Feature command.
>> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> This patch is not needed by this series except the opcode enumeration.
>> ---
>
>Wait, then why is it included?
>
>I would say fold the small bit that you need into the previous patch, espe=
cially if
>we think that fwctl can cover all the "get feature" use cases.
>
>>  drivers/cxl/core/mbox.c | 41
>+++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
>>  2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 4ba56f3d5a65..f70bd7d28ff8 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -968,6 +968,47 @@ int cxl_get_supported_feature_entry(struct
>> cxl_dev_state *cxlds, const uuid_t *f  }
>> EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
>>
>> +size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_u=
uid,
>> +		       enum cxl_get_feat_selection selection,
>> +		       void *feat_out, size_t feat_out_size) {
>> +	struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
>
>cxlds is otherwise unused in this function, just pass in @cxl_mbox directl=
y.

Hi Dan,

I  modified to cxl_get_feature(struct cxl_mailbox *cxl_mbox, ..) in the EDA=
C CXL features setup and tested fine.

Thanks,
Shiju
