Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401E213255;
	Fri, 10 Jan 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527607; cv=none; b=SVz948suaLPkNbJDx95089zqh+uLnz0mjWWOmoRA5iwurOkIZ1HvII7Z2DSN/0hSu+UHg57TZsbhXpmIllpL/NGrt3hh0B8RbwCloYjnK0M3GdF8OKFeEPeDCzW9Khy74LDVWxeUCkZCwRLgjy+zqKZDZuw3ytotS/n7ZPVU9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527607; c=relaxed/simple;
	bh=Zii7XqOSGbbXceje4R3ZkaqSRVRGq0FlF0XIASCT+vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GedtBIEON4MHK/J8MQuNwcL+aJtwhWSFh9WB3g2Z+sKia9G8WxFC7zGuGP7PTZG/Zq75qMk+gdoFqozKm/AjRXFJn6c/XGx+kk4SMUOzNebUeHRlpzwh2HXlComesCiQpmxmFK8b2sU+9wOyvLyMtDScbJ/5wZoHWN4RR9iYqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV6vh25f2z6M4NM;
	Sat, 11 Jan 2025 00:45:04 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 468D614039E;
	Sat, 11 Jan 2025 00:46:42 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 17:46:42 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 10 Jan 2025 17:46:42 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>
Subject: RE: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Thread-Topic: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Thread-Index: AQHbY1alsZyFrQ7OeU6mHkMzrNfbP7MQG9mAgAAamgA=
Date: Fri, 10 Jan 2025 16:46:41 +0000
Message-ID: <1b090d80a49a47e7b220aca07dce4cae@huawei.com>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110160645.00007b74@huawei.com>
In-Reply-To: <20250110160645.00007b74@huawei.com>
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
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 10 January 2025 16:07
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel=
.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=
;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
>
>On Fri, 10 Jan 2025 11:55:50 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add updates in the CXL events records and CXL trace events
>> implementations for the changes in CXL spec rev 3.1.
>>
>> Shiju Jose (6):
>>   cxl/events: Update Common Event Record to CXL spec rev 3.1
>>   cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
>>   cxl/events: Update General Media Event Record to CXL spec rev 3.1
>>   cxl/events: Update DRAM Event Record to CXL spec rev 3.1
>>   cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
>>   cxl/test: Update test code for event records to CXL spec rev 3.1
>>
>> Changes:
>> V4 -> V5
>> 1. Reverted changes made in v4 for overcoming parsing error when
>> libtraceevent in userspace parses the CXL trace events, for rasdaemon.
>> This was due to trace event's format file is larger than PAGE_SIZE,
>> not supported reading complete format file in one go in the kernel and
>> thus fixed in the rasdaemon.
>
>Great to see that resolved.
>
>> 2. Rebased to v6.13-rc5.
>
>Should probably say why when doing a rebase to something other than rc1.
>In this case this is what cxl.git/next is based on after some fixes earlie=
r in the
>cycle so a sensible choice for this set.

I checked. These patches applied cleanly in cxl.git/next and buid okay.=20

Thanks,
Shiju
>
>As far as I'm concerned this set is ready to go, but more eyes always good=
 if
>anyone has time! Same for the ras-daemon series once this is queued for th=
e
>kernel.
>
>Jonathan
>
>> 3. Tested with rasdaemon and ras-mc-ctl tools updated for CXL spec rev 3=
.1
>>    event record changes.
