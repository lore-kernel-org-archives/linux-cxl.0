Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280E1B952
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075329; cv=none; b=DNouax5NfCPzbCRypK9fJdmxo3YmrMiQ8olqOXM5ScQNy1PjiPp4jeE9OR7P9NBwyPZeh4vVHCrks+Gz8SBa+1HP1RSu/GDY0J49RS1ILdL/gceFsRwnIpCLU6Dzx0nNzkTheiQhvYzytMGo05HWqgLZ6TnUiaDATa3XSdw94c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075329; c=relaxed/simple;
	bh=ENngUxwPrVpKUQm3GxLfMSdqPDnhvXU3+J689ie4n0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xe1y07wT705CV/SHYNtlbbyomUp2JyMirIpa16YCQDgjsPAy3HKot+kZnXoEHgQSFWssUx5SBDlQewyMqB8udj9zhklPsDE8mysNXUbByHbjCYDK2G3ITqSRbQMvclOOebKl54YcTAtrm7mbxSOqDEy4FMH+LTWHqoAMrQzLijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbmZM0Cw3z6D8Wh;
	Fri, 16 Feb 2024 17:18:35 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id D130E140519;
	Fri, 16 Feb 2024 17:22:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:22:03 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 16 Feb 2024 09:22:03 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Thread-Topic: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Thread-Index: AQHaHt2kJ4PdrZ71Z0aqfP094Oyp27EMNj6AgAD+9mA=
Date: Fri, 16 Feb 2024 09:22:03 +0000
Message-ID: <1171bf05d6e34c57b3a6ae9bfdfe607e@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <Zc5TId-xVNl82xbJ@debian>
In-Reply-To: <Zc5TId-xVNl82xbJ@debian>
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
>Sent: 15 February 2024 18:09
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands=
,
>device patrol scrub control and DDR5 ECS control features
>
>On Fri, Nov 24, 2023 at 09:53:34PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for the feature commands, device patrol scrub control and
>> DDR5 ECS control features.
>>
>> CXL spec 3.0 section 8.2.9.6 describes optional device specific features=
.
>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> control feature.
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub
>> (ECS) control feature.
>>
>> The patches are available here,
>> https://gitlab.com/shiju.jose/qemu/-/tree/cxl-scrub-2023-11-14
>> and is based on Jonathan's branch
>> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-10-16
>>
>> Changes
>> v1 -> v2
>> 1. Changes for Davidlohr comments. Thanks.
>>  - Changed CXL SET feature data transfer flags as enum.
>>  - Modified pointer supported_feats to get_feats_out.
>>  - Removed an unnecessary branch.
>>  - Use MIN().
>>  - Move setting of hdr.nsuppfeats further down.
>>  - Return CXL_MBOX_UNSUPPORTED if non-zero selection flag is passed.
>>  - Add more IMMEDIATE_*.* flags set_feature.
>>  - Corrected a spelling error.
>>
>> Shiju Jose (3):
>>   hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
>>   hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
>>   hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
>>
>>  hw/cxl/cxl-mailbox-utils.c | 360
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 360 insertions(+)
>>
>> --
>> 2.34.1
>>
>
>Recently, Jonathan has updated all the specification references to align
>with cxl spec r3.1, so for the next version, we may want to also do
>that.

I had posted recently v3 of this series updated for spec r3.1. Please find,
https://lore.kernel.org/qemu-devel/20240215110146.1444-1-shiju.jose@huawei.=
com/T/#t

>
>Fan

Thanks,
Shiju
