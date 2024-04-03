Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DD14C5B4
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156926; cv=none; b=FdYQ25hidFpaVBlNBxou785p33Ue3+esVaR5kIT/HrYEHF3ZgrfGxtvlnqeJTDpPWKwAIxe5UMNaGP8OBF1cXI3NUCchn39NgQwjJS2eQkmB3DVd4mrpIk7PCz4UzDru2iKyzBRt7ZOpznUKfKiy+cqmX2gmBuw0sIcrBWntduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156926; c=relaxed/simple;
	bh=KP4FSDYX2aMqZv+pIlNyTSll1k/A7gW/cPjAnaZSoy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyqEnPs5NB92C9Acxeec4W+g7/zGwxPMZSfXgWu5qBaPz5x404G/um7ePO97jrJGt30DgvHqLBlZvzU0gfQprl/q+rSnRfkxJHDnrkkmnkRtYnt93MPBKf2bBgykiwT3Hc10q/i0N12M6ytCQnIF0DRLpmMz0ZJcbv88lZAi1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rp7qLu7m; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rp7qLu7m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712156923; x=1743692923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KP4FSDYX2aMqZv+pIlNyTSll1k/A7gW/cPjAnaZSoy0=;
  b=rp7qLu7mdtV6/9q47YMdShJ3kLliun9qkDh+86T5OI7zcfz/oYEvfriL
   rRbvxsEuMZZUSLOs/oIXCNGeY7VF/q3EPyPr4f1D7HQLXuAaOxJ+rhA9l
   KE15A+QIDzCQxRt/5btSxHB67odWRvw67+V2y2TNjKAoQg6moC8BETeJW
   YH3MeAlwHTu+m7Pli4zozZzIAHffat0fcxZdzk8yBz/oETR2mTZwMEM59
   ISP+suiY69B+DnYby1WVTrbD9rJRnehwH0Py2OF5VonVKN32HRXXfLrj2
   WlOLIjHyh2mLpfY/9Wk3oxM7RVruu1N2Z6qUOu/1K9Y5ECYQ8IbTWr0q0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="142108863"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; 
   d="scan'208";a="142108863"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 00:07:31 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 30BEF7440B
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 00:07:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F18DFDA70
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 00:07:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 12C8620079DC0
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 00:07:27 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4EC671A000A;
	Wed,  3 Apr 2024 23:07:26 +0800 (CST)
Message-ID: <ae5c692f-695a-460b-91e2-6f06fd7f7a05@fujitsu.com>
Date: Wed, 3 Apr 2024 23:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from
 debugfs
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
 <6607704e65437_19e0294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <6607704e65437_19e0294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28296.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28296.000
X-TMASE-Result: 10--4.980400-10.000000
X-TMASE-MatchedRID: J/NqXV0mzJePvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bmC+wH+KoDcqrpDDtyGscHMhblrt58Tvtlu85dvadcXUWqeZpZ9fc87Xl40gTGJ5pOiw
	t/WQfkJ9aM5U7dRXqm1+24nCsUSFNo15kJcETr3kE5D6PipCVdPoLR4+zsDTtjoczmuoPCq3PYP
	bCwt2AFNOepa69rWvf6wqJXNoGNOpDREfkwEJZkZFNs5Eh8tEZYUQsh3/i8KsV28zrYASWFI6x6
	pFVNL4fV/09m+gxY2iCiQtlEospUZ0Lgc2h7es/sjK6bXr6nJnV6V/ILXK7r4UrjkLnsIE8
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/3/30 9:52, Dan Williams 写道:
> Shiyang Ruan wrote:
>> Poison injection from debugfs is silent too.  Add calling
>> cxl_mem_report_poison() to make it able to do memory_failure().
> 
> Why does this needs to be signalled? It is a debug interface, the
> debugger can also trigger a read after the injection, or trigger page
> soft-offline.

I was thinking that the poison injection should trigger a chain of 
events.  So, for debugfs they should be independent, right?  I wasn't 
aware of this.  Will drop this patch.


--
Thanks,
Ruan.
