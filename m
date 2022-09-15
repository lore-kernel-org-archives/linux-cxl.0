Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB2EC6FA89
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Sep 2022 16:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIOQDs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIOQDs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 12:03:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142CA52E4B
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663257827; x=1694793827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=29J33dIr5d6V3+lOLrELvzI7JYgk3mSQ+3I+pCOejBU=;
  b=EsrNQXvdvWPRd1FGNUjq89xRj3Fi0DdORf0T6rtfCvjBWX1Qls1jtQfj
   pSQBIdSVuh/wrRUxnl26s4knPjjmGwcNP23BVlYVk+syfRsjhOxDYzro0
   0X8OFbryzHen3SFVOpxbCb705zgTceEdaB1EtPIiKYrvEh/atREIBfH/b
   t1toaKdNNmeH4VEJKT1pNXsapOmGMQIyPjwM6pDGodk7DL9VNtv5ApPX4
   yvZVsNGJOr2iPi98gz3FoH8v2ZCN1r2ashu/XXKmYHCh+jDCBYXsLup+B
   Xc/0Z5EZ+cEsc0/RPmqEjMWNe7c7zbsPOF29M/lBfcvGs1X+LAiOUhMLH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="299567381"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="299567381"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:02:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="594879108"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.96.71]) ([10.212.96.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:02:50 -0700
Message-ID: <d5855ea8-aac8-03fa-6ff4-7fb7afe02a73@intel.com>
Date:   Thu, 15 Sep 2022 09:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 6/7] ndctl: cxl: add logging functions for monitor
Content-Language: en-US
To:     Nathan Fontenot <nafonten@amd.com>, linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318850459.3087953.851045527272435004.stgit@djiang5-desk3.ch.intel.com>
 <40400223-a228-457a-e65f-61598dfa45c3@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <40400223-a228-457a-e65f-61598dfa45c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 9/15/2022 8:55 AM, Nathan Fontenot wrote:
> On 9/14/22 15:48, Dave Jiang wrote:
>> Duplicate log functions from ndctl/monitor to use for stdout and file
>> logging.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
>> ---
>>   cxl/monitor.c |   26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/cxl/monitor.c b/cxl/monitor.c
>> index 2ab2e249f575..e030542a3fe8 100644
>> --- a/cxl/monitor.c
>> +++ b/cxl/monitor.c
>> @@ -39,6 +39,32 @@ static struct monitor {
>>   	bool human;
>>   } monitor;
>>   
>> +static void log_standard(struct log_ctx *ctx, int priority, const char *file,
>> +		int line, const char *fn, const char *format, va_list args)
>> +{
>> +	if (priority == 6)
>> +		vfprintf(stdout, format, args);
>> +	else
>> +		vfprintf(stderr, format, args);
>> +}
>> +
>> +static void log_file(struct log_ctx *ctx, int priority, const char *file,
>> +		int line, const char *fn, const char *format, va_list args)
>> +{
>> +	FILE *f = monitor.log_file;
>> +
>> +	if (priority != LOG_NOTICE) {
>> +		struct timespec ts;
>> +
>> +		clock_gettime(CLOCK_REALTIME, &ts);
>> +		fprintf(f, "[%10ld.%09ld] [%d] ", ts.tv_sec, ts.tv_nsec, getpid());
>> +		vfprintf(f, format, args);
>> +	} else
>> +		vfprintf(f, format, args);
> The vfprintf() is always done here, you could just move it outside the if/else block.

Thanks! Will move. I just blindly copied the code from ndctl/monitor.c.


>
> -Nathan
>
>> +
>> +	fflush(f);
>> +}
>> +
>>   static int monitor_event(struct cxl_ctx *ctx)
>>   {
>>   	int fd, epollfd, rc = 0, timeout = -1;
>>
>>
