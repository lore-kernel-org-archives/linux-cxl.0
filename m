Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A086524C;
	Tue, 30 Jul 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321516; cv=none; b=hycHgYDN7tfTNnXDPJIEtxjg/dYmBh/WVUdt+CvIXbok+OdcocpDR/yH9iSMSI15KsRANi3HHg6gwggf9BAbv1crfLKpssYPq1iKJqBPPCDtNEBEh6qcwEdLMuSXYJocfWzuWNqJSaTXZvbgE7IAqgdeUuzZZHqoAhuGtfMQmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321516; c=relaxed/simple;
	bh=ukOrP/zsX98jvqz8B0nhiPzd/t1172dLQmIwQiSiskA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPR/4ngUKltk83lAVmINUszUoWL0QXnxyTSFNO3IJHChII0vTVcEo4uRpUy3EYj2uNnH0PNJ5JjoCnlGbkXiKhLtmG2Gz0AKTcSwMZFBy7ADs5+hJKW7dbCgMZFRZsXOHkLrDJkzsH2wOVEq/qpEhzHtYgQG2OHYPTGlsCrydVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llkNBFSk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llkNBFSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722321515; x=1753857515;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ukOrP/zsX98jvqz8B0nhiPzd/t1172dLQmIwQiSiskA=;
  b=llkNBFSkKw9IZZO8kEjlqOdqqWiDxAkr2WVkZuPUn+pZzytRvTmRLXkN
   jOXAu0gW49yKn+tgpV52M4xQL3mdrEZuJ0eI9Ts/yvHZWe0RZ/Mg7y8in
   nXpe1HvW+3G0ZfXnMd6Yf1gyV7ja5h9qFOR2+VBS7qqxH3rDM+KCQQyYi
   2o8vYWQoYed10eNsyUBBY6FAyoldoEBUA25ge+av3vmQVoCQKUCJ0aDes
   3uqB5Ue6HfrI1eulxpq2Jait0achg+q5J6s74lt7Sc/8OrbKE2p/f/E1F
   Q4eg5pjryixKJSK7ma21IilGREXvFn5kRgZDx8pZFkjjbzBiFblrDvHxG
   Q==;
X-CSE-ConnectionGUID: OQn6OZENSBae4LzGr6Fvnw==
X-CSE-MsgGUID: VB0u+ZO2TaiYGgB96ct4Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31264871"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31264871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 23:38:34 -0700
X-CSE-ConnectionGUID: L4Zw+PIyS3exPFKjAaMocw==
X-CSE-MsgGUID: 6dXkDf5XREexXfN1/Gf9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54475821"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 23:38:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Davidlohr Bueso" <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/3] cxl: Preparation of type2 accelerators support
In-Reply-To: <b69304e8-d43c-940c-9ee0-d2345ef7b99d@amd.com> (Alejandro Lucero
	Palau's message of "Tue, 30 Jul 2024 07:10:25 +0100")
References: <20240729084611.502889-1-ying.huang@intel.com>
	<b69304e8-d43c-940c-9ee0-d2345ef7b99d@amd.com>
Date: Tue, 30 Jul 2024 14:34:57 +0800
Message-ID: <8734nrtmjy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Alejandro,

Alejandro Lucero Palau <alucerop@amd.com> writes:

> Hi,
>
>
> I'm a bit "surprised" by this patchset. As you rightly say in this
> cover letter, there is a patchset under review, and I have not seen
> you commenting there on the concerns stated in this cover letter.
>
>
> I would say that is the first thing you should do, at least, to
> comment there, suggest to do other way, pointing to other needed
> changes, and if things do not go well for reaching an agreement, then
> a patchset like this could make sense exposing another way.

Sorry for confusing.  The patchset is just some preparation work for
type2 accelerator support.  Your patchset is more complete.  I just want
to relief your overhead a bit.

> Anyway, I think a CXL maintainer should say something about it, but
> after 24hours, I had to say something.
>
>
> About testing these changes, I wonder how did you proceed. If you have
> used an emulated Type2 device, as I did with the first patchset
> version, you should trigger some of the problems I found, what makes
> any Type2 initialization for getting a memdev and finally a cxl region
> to fail. In other words, testing these changes can not be a partly
> initialised Type2 but a complete one. This does not mean a patch
> fixing a known and obvious issue for supporting Type2 should not be
> approved if not tested, since the Type2 support is not yet there, but
> mentioning testing makes things confusing, at least for me.

Yes.  To test this patchset, I need more complete type2 support.  I used
some patches from your and Dan's patchset on top of this patchset to do
the test.

>
> On 7/29/24 09:46, Huang Ying wrote:
>> There have been 2 series to add type 2 accelerators support in [1] and [2].
>>
>> [1] https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
>> [2] https://lore.kernel.org/linux-cxl/20240516081202.27023-1-alucerop@amd.com/
>>
>> Both provide relative complete support, but both are long too.  To
>> make it easier to review, some preparation of type2 accelerators
>> support is implemented in this series.  More complete support can be
>> implemented based on it.
>>
>> This series has been tested with cxl_test via mocking a type2
>> accelerator as in [1] above.  Because more type2 accelerators support
>> than that provided by this series is needed to simulate the device,
>> the cxl_test patch isn't included in the series.
>>
>> Huang Ying (3):
>>    cxl: Set target type of root decoder based on CFMWS restrictions
>>    cxl: Set target type of region with that of root decoder
>>    cxl: Avoid to create dax regions for type2 accelerators
>>
>>   drivers/cxl/acpi.c        |  5 ++++-
>>   drivers/cxl/core/region.c | 11 ++++++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)

--
Best Regards,
Huang, Ying
