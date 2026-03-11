Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529043CCFC9;
	Wed, 11 Mar 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227707; cv=pass; b=JN0CUgN/l7LR0wsJlXzgZZttkGCpyW2idzy+85zqUwmz0J7hu1CjSmHGHTzNjjDBNoudeIjgmZxAq+HOVf3H3k5teDvOrT39UwABzp4ALaNvvS4GJ2mhh5gPVC2NCYoJj9/0qSUKAJ8ILRGOXPQKUi46ISK0HKCcqclRjqsbIHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227707; c=relaxed/simple;
	bh=o9EyTz8DpnDwAOE8fDGAzp1VAO0H5Tw14Vxycg+jO0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnx/6+IpjPP5aEtIN8TLTGPY4DM0Xs46zNapJBvWMCYJ1ai6FEaJdEljyrQNhJb9xdp2Db8FkpmfCoyLnEGjXY9h9QUsxN1IKHzYf3uEx2VRtjbfp4v63lNdC28/fygGlsmaRY1hgb+sJC9JvI5olG0V9V7JoawJ+Vrk5PuJcpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BvZZCgGj; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BvZZCgGj"
ARC-Seal: i=1; a=rsa-sha256; t=1773227519; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UqlvXTWcNrvh5rzQLH23Hln22Xl6MWgQjAp1kQbDdDJHgE5S99OpbGDX1+LidLjWxmOHGj3L9WP+ysgo4vS6hHDGfGmgISfK1vz0OeBuNMlkU+hzopA5nxt5QlVxmVIm/bv98ezc/l6iWLIYeVypmI0N9YQDA85PWkM6NE0CPzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773227519; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o9EyTz8DpnDwAOE8fDGAzp1VAO0H5Tw14Vxycg+jO0U=; 
	b=gXqydCUe5UuNGLk7asv6olZRXkhSiKwsDWMQdWIdq33lgiRFs6NXdjtynwEGAGkmQicVV5w9eveFodADvLgcHGZs3+sr7VDUuIC6QIzO/gBwCVSA4MA88yitnQV5VKrVNa1NQpirUtpWT8XpoSJPTiZ61Em6wGtCHc+z2goP+To=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773227518;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=o9EyTz8DpnDwAOE8fDGAzp1VAO0H5Tw14Vxycg+jO0U=;
	b=BvZZCgGj0YQt3XkmXDe6/w9VtmmYAwbcJ2jmKin4+h22d8akH2DQSeQZXVcBsEej
	TyJ/WzMO+ZylUTf1eO+fKQDwxAK2NJoNuO/3um5CepCMeG1TQeVXrMUByeRWmJZPjnA
	MgSh6Q0xrVFydcEz91MvLjsPYP4uR8gl5BaxrYhk=
Received: by mx.zohomail.com with SMTPS id 1773227517630851.3620462808262;
	Wed, 11 Mar 2026 04:11:57 -0700 (PDT)
Message-ID: <e5a15f4b-1d2a-46fe-bb9c-cd77d78b823c@zohomail.com>
Date: Wed, 11 Mar 2026 19:11:53 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cxl/pci: Hold memdev lock in cxl_event_trace_record()
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-4-94fe919a0b87@zohomail.com>
 <69b0722764c48_490a1007f@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69b0722764c48_490a1007f@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122831893dbab0ee8e91323e74af0000f2a7fdab57cf4f5b7a176cef6b2292d6ef7ef30c78e2989db304:zu08011227c6bd3004aeba7678bcd2deee000082f0d642e47281c01c2222cd07518d98992e29626f1dad8f1a:rf0801122dc75ed5add7fa096f99b8e41e00005ea55032d3579638f6c4b4ebbc65bdd32b1a3cc0138f59ace5ceb99b52888f:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 03:33, Dan Williams 写道:
> Li Ming wrote:
>> This is a preparatory patch for the following changes.
> It is a preparatory patch that does not stand alone though.
>
> I would squash with the next patch, but you can add to that combo:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
Sure, Will do that in v2. Thanks for review.


Ming

