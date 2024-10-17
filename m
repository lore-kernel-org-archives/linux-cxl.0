Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56E1DE3AC;
	Thu, 17 Oct 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176224; cv=none; b=dHnKHT3N0NqZD9SVU0FRtto3l7lfs79CY4sqbOe1ZXhePHOxRNiqE1wSWlaH4ywNxVbRwKhlUAB5NfrpQ7mZQjOQcPohlMk+XWOApbrvjQWhdOgG16Wsm/AwrUp3cUAS+EZHfH8N7xiDKZGUwU2VDv+tNeRYkE/SvYp9LWw142g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176224; c=relaxed/simple;
	bh=6qwJrVcIOUZ3WS3kYsWspxVWsMYL5WvIEdvEyPQufMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=slxBcDTJQRSbYxdBsmMBANAHe5z0xdixEd4d9rJkFM7yU+FexLc/HB6H5Sa3hFVJ6vHNAemIQeiI4YgKJPiesdBHyYMONJWRAIGwHvXXItO2fW9HcyDZjbwAHiuOQtIex2v46EaShWSI6mIS3WtelXKg4ypU1f3ixfoVPxOb/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTrBm0y5Tz6FH0j;
	Thu, 17 Oct 2024 22:41:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FB311400F4;
	Thu, 17 Oct 2024 22:43:36 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 16:43:36 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 16:43:36 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH 4/4] cxl/events: Updates for CXL Memory Module Event
 Record
Thread-Topic: [RFC PATCH 4/4] cxl/events: Updates for CXL Memory Module Event
 Record
Thread-Index: AQHbH+lB/P/6Hqe5eECBgniXYnp24rKKwzSAgABCoTA=
Date: Thu, 17 Oct 2024 14:43:35 +0000
Message-ID: <e99a2fa9a3c4416da5e62b98b9c46e6c@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-5-shiju.jose@huawei.com>
 <20241017134417.00005c6b@Huawei.com>
In-Reply-To: <20241017134417.00005c6b@Huawei.com>
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
>Sent: 17 October 2024 13:44
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel=
.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dave@stgolabs.net; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>
>Subject: Re: [RFC PATCH 4/4] cxl/events: Updates for CXL Memory Module Eve=
nt
>Record
>
>On Wed, 16 Oct 2024 17:33:49 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event
>> Record has updated with following new fields and new info for Device
>> Event Type and Device Health Information fields.
>> 1. Validity Flags
>> 2. Component Identifier
>> 3. Device Event Sub-Type
>>
>> Add updates for the above spec changes in the CXL events record and
>> CXL Memory Module trace event implementations.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>A few minor things inline, but with the event_sub_type naming feel free to=
 add
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>>
>>  	CXL_EVT_TP_printk("event_type=3D'%s' health_status=3D'%s'
>media_status=3D'%s' " \
>>  		"as_life_used=3D%s as_dev_temp=3D%s as_cor_vol_err_cnt=3D%s " \
>>  		"as_cor_per_err_cnt=3D%s life_used=3D%u device_temp=3D%d " \
>> -		"dirty_shutdown_cnt=3D%u cor_vol_err_cnt=3D%u
>cor_per_err_cnt=3D%u",
>> +		"dirty_shutdown_cnt=3D%u cor_vol_err_cnt=3D%u
>cor_per_err_cnt=3D%u " \
>> +		"validity_flags=3D'%s' comp_id=3D%s sub_type=3D'%s'",
>>  		show_dev_evt_type(__entry->event_type),
>>  		show_health_status_flags(__entry->health_status),
>>  		show_media_status(__entry->media_status),
>> @@ -750,7 +782,11 @@ TRACE_EVENT(cxl_memory_module,
>>  		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry-
>>add_status)),
>>  		__entry->life_used, __entry->device_temp,
>>  		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
>> -		__entry->cor_per_err_cnt
>> +		__entry->cor_per_err_cnt,
>> +		show_mem_module_valid_flags(__entry->validity_flags),
>> +		cxl_print_component_id(__entry->validity_flags,
>CXL_MMER_VALID_COMPONENT,
>> +
>CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
>> +		show_dev_event_sub_type(__entry->sub_type)
>If we are going to reorganize for the other patches, why not move this nex=
t to
>the event type field?  There isn't a validity flag for this (0 means not s=
pecified) so
>fine to move it earlier I think.
Will do.
>>  	)
>>  );
>>
>> diff --git a/include/cxl/event.h b/include/cxl/event.h index
>> 7e98492c85df..18b7f96dea77 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -102,7 +102,10 @@ struct cxl_event_mem_module {
>>  	struct cxl_event_record_hdr hdr;
>>  	u8 event_type;
>>  	struct cxl_get_health_info info;
>> -	u8 reserved[0x3d];
>> +	u8 validity_flags[2];
>> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
>> +	u8 sub_type;
>maybe event_sub_type to match spec naming?
Will do.
>
>> +	u8 reserved[0x2a];
>>  } __packed;
>>
>>  union cxl_event {

Thanks,
Shiju

