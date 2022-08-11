Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3CC25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiHKXdk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiHKXdk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:33:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4A979D0
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660260819; x=1691796819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9W3akjwxmGS2g8cPaeatFunQUwkabRT40c7maJ/PfCQ=;
  b=Sw1/Mbbt31hofr0flyRAl4Nv+qhwD8nLTQn5dmzT9KrDhe2WRhVChdPj
   DNN0L7/PIViLxxZR0ltUWyhTO3iPpWmQ+YgiBZvJ75uIGE7Us6IAN2N2B
   jI79xWstGZKmWYlO4+Kh+4SufXxKsuyPF/71qUHb1wadOl8h7odkvT1Wg
   pA1kERLURADKaI4tptI/q3XYq3ipl2J0tBmBMdUZGWjuBxF+HefiECjoX
   oKJciuPVuxzgyi+PtF8Hj7Q4G3kfv2EiHzPr+Z2MGlXzbJCtV/diexpy0
   wR3ESoEXkm3/hyOHF6bB7VoHusTJgxCoMxfxWzWuZQK3XdE72rLIMJoCd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="377775898"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="377775898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="933513452"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.81.242]) ([10.212.81.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:33:39 -0700
Message-ID: <f6af9eed-a43d-1de7-b838-47cf674c44c4@intel.com>
Date:   Thu, 11 Aug 2022 16:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
 <20220809170630.GA1756195@alison-desk>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220809170630.GA1756195@alison-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/9/2022 10:06 AM, Alison Schofield wrote:
> Dave - Haven't reviewed yet, but wanted to drop this tidbit -
>
> On Mon, Aug 08, 2022 at 02:06:57PM -0700, Dave Jiang wrote:
>> Add a helper function to check the combination of interleave ways and
>> interleave granularity together is sane against the interleave mask from
>> the HDM decoder. Add the check to cxl_region_attach() to make sure the
>> region config is sane. Add the check to cxl_port_setup_targets() to make
>> sure the port setup config is also sane.
>>
>> Calculation refers to CXL spec v3 8.2.4.19.13 implementation note #3.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> snip
>
>> +static inline int cxl_interleave_verify(struct cxl_port *port,
>> +					int ways, int granularity)
>> +{
>> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>> +	unsigned int addr_mask;
>> +	u16 ig;
>> +	u8 iw;
> s/ig/eig
> s/iw/eiw
> For consistency, let's use the "e" version of these names to mean
> encoded value.

Ok. Good suggestion.


>    
>
>> +	int rc;
>> +
>> +	rc = granularity_to_cxl(granularity, &ig);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = ways_to_cxl(ways, &iw);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (iw == 0)
>> +		return 0;
>> +
>> +	if (iw < CXL_INTERLEAVE_3_WAY)
>> +		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
>> +	else
>> +		addr_mask = GENMASK((ig + iw) / 3 - 1, ig + 8);
>> +
>> +	if (~cxlhdm->interleave_mask & addr_mask)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>   struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>
>>
