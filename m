Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A06F076;
	Fri, 16 Aug 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783984; cv=none; b=iA1HNjfyRg3XC9iz6RxRSnvePRl/CpgXMsj7EwRijHZbf7tywhJ+gap8tnOHitp0dzgGkjyo9ZbzDL3h6Idebab+YepwgWMHzNARPbYotptAtc/UQAPq6cnGk+odEbFK7BXy3/vXAZmWfFwxAw+1aT/XXK+Kg8ZpjqqdVCW3wbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783984; c=relaxed/simple;
	bh=zdLM0KIP970E4GbthIkogSEpCsJYb5OSpA3ofPumAe8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N9KNfN7Ax1P6aQt7zPv2O5A1giIJMl94zCXT3qtD5LIEp2uMl/rpRAZ5LM2c92LHeaLlQBGyGWGTGvxnIe8RsVRz6PGIAQAqa6jFeSRP8/8ah+OVNcHCZ+JlFN4HKk1J3X+RkmJ2mUQnwPabZ9idq7Yyn5VDCroH/004wPY7pWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v6VR5slJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v6VR5slJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63512C32782;
	Fri, 16 Aug 2024 04:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723783983;
	bh=zdLM0KIP970E4GbthIkogSEpCsJYb5OSpA3ofPumAe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v6VR5slJWMCcwANxphEdf8OCr/x0DfvnAW8+cGd7YvQYL6QlzHHQ+dZmxVcPAOhOd
	 w0IW1eMdj59ZslsO9qhyIUCzIII6iLICD1gDYuRwi2DKpOoebyGbtUO4H9tUKcvKHb
	 dYkUQhgKWSj3O4jfEUOoqvcTR0yAs2gVWaPdER/Q=
Date: Thu, 15 Aug 2024 21:53:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huang Ying <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
Message-Id: <20240815215302.5ed29b99e94a48aea49269ce@linux-foundation.org>
In-Reply-To: <20240816020723.771196-1-ying.huang@intel.com>
References: <20240816020723.771196-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 10:07:23 +0800 Huang Ying <ying.huang@intel.com> wrote:

> On a system with CXL memory installed, the resource tree (/proc/iomem)
> related to CXL memory looks like something as follows.
> 
> 490000000-50fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
> 
> When the following command line is run to try writing some memory in
> CXL memory range,
> 
>  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>  dd: error writing '/dev/mem': Bad address
>  1+0 records in
>  0+0 records out
>  0 bytes copied, 0.0283507 s, 0.0 kB/s
> 
> the command fails as expected.  However, the error code is wrong.  It
> should be "Operation not permitted" instead of "Bad address".  And,
> the following warning is reported in kernel log.
> 
>  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
> ...
>

Presumably we want to fix earlier kernels?  If so, are you able to
identify a suitable Fixes: target?  Possibly 974854ab0728 ("cxl/acpi:
Track CXL resources in iomem_resource")?
