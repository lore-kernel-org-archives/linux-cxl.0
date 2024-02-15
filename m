Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F8132480
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013991; cv=none; b=QvxWgUG+6UDZ4qjmn8R6278KwWdGdeb91+SPh/sUbq8BZag8Mm7D0letOcCtujBENOQqrzlh5T9Ys+v5POTqu73Msxkq5n82e/pkqHjY6g+1KRT2wKYiC5CjLwZCdSzxp5lUr9Fm9ffDWhRzEjwoCLHc7MQtrdA9dNqjkgeMKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013991; c=relaxed/simple;
	bh=IV1EL3vQ3L9uK6D6z/j1Zyn2KP8hiTbI3mpmzwFAGeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+SOVXoCuMGHZEhIT1oQsBilX6OOS7mu/TtJlOuCNrMuBf61Gi7cVU/5/sCJT12n3fE3HkBfZBauKRBV8SW7BrirTzbDl4aBiesw7Es3jOGjtO3W3Hm2VFtPzt1W673a0pwX75yTh9QjweMh0QD5WnUVUmBcy0oOinPEIYt5Kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNBk4lkl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNBk4lkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708013989; x=1739549989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IV1EL3vQ3L9uK6D6z/j1Zyn2KP8hiTbI3mpmzwFAGeg=;
  b=CNBk4lklvXa3CZp3WSaFzHVoNwY4YXQU6ovDihTey1jTnVw1zgYPjyB3
   X09gEFUTXQFCi6qZjy0BghCvB0TNWOGY8B5SOm0pqoJEZUHQBAoFlws8y
   kYIEVDp2bf591DCMQE6iZOhvgNkGC66RP80hZ2WFGeocAy0YQpPEdNmwT
   d29yb3A8bXxdZA4FzfKVbiQ/0BVu9S2/150cVp8T1/qNE4WFylZ6qKy20
   2bP8uOLPGopXRlAs+rn7Cp87AsZMZDfBiZHtwMBUXFNDaNM+MMi+htJhH
   PeHVxBQONOlmoWPHt8RbwU6x9vi0DLc5WkcfKRtU9qu1KBDBsUhMqf2ch
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19624986"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="19624986"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:18:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="826432095"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="826432095"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.87]) ([10.246.113.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:18:56 -0800
Message-ID: <922b74ff-84db-49f8-9653-7e81a7fa0ccc@intel.com>
Date: Thu, 15 Feb 2024 09:18:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cxl: Fix memdev qos_class sysfs attributes
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240206190431.1810289-1-dave.jiang@intel.com>
 <20240215161709.000053c0@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240215161709.000053c0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 9:17 AM, Jonathan Cameron wrote:
> On Tue, 6 Feb 2024 12:03:36 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> v5:
>> - Only update the perf sysfs groups (Dan)
>> - Remove unnecessary type cast (Jonathan)
>>
>> v4:
>> - Fix resetting of dpa_perf (Wonjae)
>> - Change cxl_qos_match() to return bool. (Jonathan)
>> - Remove unnecessary void * casting. (Jonathan)
>> - Replace open code with sysfs_update_groups() helper. (Jonathan)
>>
>> This series provides fixes to the memdev qos_class sysfs attributes. The
>> current code emits duplicate sysfs attribute under the same directory and
>> the ram qos_class clobbers the pmem qos_class. Move the attributes under
>> static definitions and allow the attributes to show up under ram and pmem
>> directory individually.
>>
>> The series also adds cxl_test support in order to allow CXL CLI add a unit
>> test for qos_class attributes.
> 
> I see Dan has this queued up already but fwiw (excluding patch 4 because
> I've not looked at the cxl-test stuff for a while).
> 
> For patches 1-3
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan!
