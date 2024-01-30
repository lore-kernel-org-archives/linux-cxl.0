Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D454736
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603304; cv=none; b=BvWu6ZO7GWPNfBmyAmhLWRHT8qid1HrojsGE+eaiSZo0C/HhrXDfYbtmqHXW1ExfTd64AhqsxFoSDB5rAUQJBFS9ML9mVSBrLCy06NtPuLJm/28d7u28PtChl2Yh9cmAELHub47XJ0c77uAc6KSkkX03RioslyKGYB7qIbJKHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603304; c=relaxed/simple;
	bh=EqO0lVN9TonHK+ggCsiGx98r71izP5weSknpeaVJyEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCzbJFg1mtGzFSBtyLbWxt/T9KyYuudAeN5bectoUPA0K2obsl8k7e12vM8svZKVw5hNSWdMT035VVqkwZY3mH/xuV9gZyLsW7avERGAhH/anH6RD7EOALzK4zPSLmXbRKnKgzo0Jt4ZxOUjtVGcf0wODfl1mxtfZDQwMI0JAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JogjESDe; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JogjESDe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706603303; x=1738139303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EqO0lVN9TonHK+ggCsiGx98r71izP5weSknpeaVJyEY=;
  b=JogjESDeJCOuE247qG3XqlwwbLLC9tfev6Zc5x4mU7FlaILzGbKVCGBT
   riOT+0N0+rcZYsLvBQODF6akP9gPw6EhrLP/75ttvxujmKlNl7CtiCSVw
   3qg1N5ROcq9o4vZojatx0PXeoilr07IJJ7BGxmp838weSKOhM35Scw3Sd
   rvPJgEZtXShRlCy38Wilwz6KIa7gtbkK/FOzy3sCPztJvbwR8O3+5KC8C
   V4gqhVuQ/A19jFQnPnomx7GXKAME7T5P3vGrO5eBEfxkW0HZ4idWFfSoZ
   E3QfaCi6gZk/4otaXlM40uzH0PgfXQ8JpweFoJDjEmokOB953czX4colq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="127163360"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="127163360"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:28:14 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F395FD6501
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 17:28:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3267ED4C33
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 17:28:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BA7C2E4767
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 17:28:09 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 34E791A006A;
	Tue, 30 Jan 2024 16:28:09 +0800 (CST)
Message-ID: <ce520bbc-702f-356b-2ee2-d392121b03fb@fujitsu.com>
Date: Tue, 30 Jan 2024 16:28:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] cxl/mbox: Code readability improvement
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20240130055844.19811-1-caoqq@fujitsu.com>
 <65b89e67ca4e9_59028294a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
In-Reply-To: <65b89e67ca4e9_59028294a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28150.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28150.005
X-TMASE-Result: 10--7.960300-10.000000
X-TMASE-MatchedRID: P7d3tDo+wQqPvrMjLFD6eKpLARk+zpBZC/ExpXrHizxBqLOmHiM3wwZN
	LEcrBa0waK+ZoqLQjlfmn3xyPJAJoh2P280ZiGmRKiJEqUFWRggWUg/hm489yIEBeX0uQ+np1Qe
	RK5jbYGyC8P1XlA48LmD0bfukQQQZj2hRzH1UwuA5f9Xw/xqKXZwhktVkBBrQFybFQYnP6Tz7H+
	hZKy6/K9AtbEEX0MxBxEHRux+uk8hxKpvEGAbTDjcROKb53OdIbG9FLEsTXbEce85OTn5z9A0VC
	/gI03gMBYruvUKuB+z7xLkq9vQ4svTtoWZsuXOWnDfbV2aZx9/F2c8g9FGJMrvv66gRfoJXBh5q
	hBp6obamvGe35Ugyq6lqN/IaBZhy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


> Quanquan Cao wrote:
>> "send_cmd->id == 0" indicates an invalid command, so replace 0
>> to CXL_MEM_COMMAND_ID_INVALID to make it easy for reading/understanding.
>>
>> Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
>> ---
>>   drivers/cxl/core/mbox.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 27166a411705..2e5ee05011d6 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -485,7 +485,8 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>>   	struct cxl_mem_command mem_cmd;
>>   	int rc;
>>   
>> -	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
> 
> "non-zero" is readable to me, and less characters to parse means current
> code is literally easier to read.

Thanks, I got.
