Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8112128802
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206418; cv=none; b=a7epze1tJza2Aa/LVq6Wihn/mPbGcLgl9uHngHIXasp5rWqQ+bnTgVFn4XJG09dLqmMNX+l2lszMUjb1KLUvJQtD04n6ldfn1TwH7XA9QyLHv9WRfnJgFm9qU5x/rhsW3UbkfDKrcwRwNl7EfBDTkwriPv/L2tPyy5Hq/B8A/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206418; c=relaxed/simple;
	bh=W1I03sR0slFWl9rMfpAJF2aQF9O3eAYm5ALR0i3OZts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SIsa3CGICyd/17s0ubzaxlDoBBB7+m1dhraj3KzqixXSrlEdrvNepQ6EKwm25GNma19GnXfFUHP97B+Cm8qIkw26bSfkR+VT9m1MNtObZsuRKg6EqJBOMzjHKevrML+tD/WPrR1s+E1WYnbVanAiUV7FHDMg6oM0NvpLJ67oYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=owsGzC7C; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="owsGzC7C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707206416; x=1738742416;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=W1I03sR0slFWl9rMfpAJF2aQF9O3eAYm5ALR0i3OZts=;
  b=owsGzC7CTGTfzIxHudxz6qteeccpPa/gQYAAUOuzNNtOFCYGoVBgu2ar
   +lVP0yQQz0FHjhpiQZe0Qr/CvwaXgW/MnwwaulgBI0tJHeZ78uqZLTA9Y
   4Bg0cErZ6D1dVpWZKko/LIPMCROvjVujpoE0i+vkodnXaxrVPl2BFaO66
   BvW4tUMiSlJA51Q1qm1ExsRJ94qFSZuxKWsoAs7tQQJTOienFo3DUFV8k
   tE7WICyWVsTn/DFLfVkO+Emma/KfwcjByj/XdzZNLSkv5L7UgmZVzA61+
   C78B4Syvh9QdZogwKIINnAZzVdl+WnKo3NXYf5tGXXNo84kTQtp1nM4sX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="127931799"
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="127931799"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:00:13 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 20831D4800
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 17:00:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 19DA8D6232
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 17:00:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A03E220095246
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 17:00:09 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1BA781A006A;
	Tue,  6 Feb 2024 16:00:09 +0800 (CST)
Message-ID: <4635705b-016a-b355-3076-f29c2272b43d@fujitsu.com>
Date: Tue, 6 Feb 2024 16:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Question about a segmentation fault issue when accessing memory
 in a region
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org
References: <3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com>
In-Reply-To: <3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28170.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28170.005
X-TMASE-Result: 10-1.629200-10.000000
X-TMASE-MatchedRID: wjdoQEOKyraPvrMjLFD6eKpLARk+zpBZt3aeg7g/usAkt9BigJAcVsUN
	IL4qyZJQUZBL966rYcAyh2C7EeKtC01+zyfzlN7ygxsfzkNRlfIiukZS+aMQ2+ChKCnsNuVqxx7
	l0wJgoV3dB/CxWTRRu4as+d5/8j566qaxzMiSep0o7YEB751LIIP7smAMn2ck8GnMpX6Dwp43Fw
	PyGB317AkK4cdwOzxHJa3BjjlM+009A78QTDmwFBp0k7oWe49d
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


> Hi, guys:
> 
> I tried to create a region on the 2hb+6mem environment.
Sorry, there is an error here: 2hb+6mem -> 3hb+6mem
> Fortunately, the region was created successfully,
> and the system memory can be seen in the system that
> the system memory has increased.
