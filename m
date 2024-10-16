Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE51EB27
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090872; cv=none; b=pMORd7ubLV4/OPrlM6eLmF+7U46vTg7O9gk4qsh3yBS3cGHd2UKk8MCqzNrgGAHqZwvngsrflnUYR9thvFwlOvRyMGs4J6NcCaHEJoTTeV9duFi4Z9JYhNb7oRXtFcSv11roNgh/07bew/xiPWPpaTmPA2kwfO2WtLAfWLOZfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090872; c=relaxed/simple;
	bh=TXQOUZG34oI8hwnNV4hgV5jf5c1G54xmKTAj9iaWeIY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJA1EHeBKfjgQOppu8tdgOZ1Uhjik4QAufQAM1QtPz9PzwHCnYBClOBwizQcE8MAQQKmABSFhDQJgNTsPLip4sd3gjF16JZgtPUnTGoRHvWMBt0ia3VDK42KAfKnPYuV+piL6axl/Mopb/Sdc7Ts6MjF1PhIBhiCwWaVKAis5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTDdW28dQz6FGWL;
	Wed, 16 Oct 2024 22:59:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EA411400D9;
	Wed, 16 Oct 2024 23:01:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 17:01:07 +0200
Date: Wed, 16 Oct 2024 16:01:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <20241016160106.00004e34@Huawei.com>
In-Reply-To: <gghrbm3lt5wbjwhjrccmwercuvp6xy43mecqtezhkqznsctj5s@b2ntzbtyfehx>
References: <20240930203445.149954-1-dave@stgolabs.net>
	<20241004124432.00005b67@Huawei.com>
	<gghrbm3lt5wbjwhjrccmwercuvp6xy43mecqtezhkqznsctj5s@b2ntzbtyfehx>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 19:45:05 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 04 Oct 2024, Jonathan Cameron wrote:\n
> 
> >Driver is in perf though so you need to +CC perf maintainers as
> >they will probably pick this up directly.  
> 
> Doing the v3 to add the typo Alison pointed out, I remembered
> why I didn't Cc a perf list. Which is it? it is not clear to me
> exactly who is responsible to pick this up outside of the cxl
> world:
> 
> $ ./scripts/get_maintainer.pl 0001-perf-cxlpmu-Support-missing-events-in-3.1-spec.patch
> Jonathan Cameron <jonathan.cameron@huawei.com> (maintainer:COMPUTE EXPRESS LINK PMU (CPMU))
> Will Deacon <will@kernel.org> (maintainer:ARM PMU PROFILING AND DEBUGGING)
> Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGGING)
> linux-cxl@vger.kernel.org (open list:COMPUTE EXPRESS LINK PMU (CPMU))
> linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING)
> linux-kernel@vger.kernel.org (open list)
> 
> ... Yeah I guess it's Will and Mark, but arm seems really
> misleading and out of place for this. Imo both the cxl driver
> and pmu code should have the same maintainer scope.

There was a discussion ages ago about changing that maintainer entry
to make it more generic (drivers/perf).  With a few exceptions the reality
is that Will and Mark end up reviewing everything in there :)

Generally for PMU drivers the perf specific aspects end up more complex
than the hardware side. That's why we put the driver in drivers/perf.

I don't think either Mark / Will / CXL maintainers really care a lot
about who does the patch wrangling on simple patches like this beyond
if it is from perf side no one wonders what the CXL maintainers are doing
touching code in drivers/perf.

Jonathan


> 
> But even if this does not change, I think the maintainer entries
> should at least be labeled something more generic.
> 
> Thanks,
> Davidlohr

