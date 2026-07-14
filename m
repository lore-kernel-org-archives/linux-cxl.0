Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884933F44EB
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016416; cv=pass; b=k+BNtbQE6jeePdsgxzjd0hMw6XyM7e+/P+Ju3FqTyOeVJp0TGtCpAFi4wxW7oIScN4MM5LOyoFQIXlMBAXoksVhpV2uhAR7kb76SQO51nQ3KBIPTMHYrSCbVKqg3Q8/khVsfjbYi45ECelwCMnFvpMiJs8lE1m4p2dxeePMURXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016416; c=relaxed/simple;
	bh=OAXp9LLbLmdZdd2SsU2AjAvMnbnGuoGKZn6k6wG62sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldhqMiUWKOhJN7u9wxN/iXHunFYMrqOQAX/zjlq4IwtsOXkAupjCJO5yxrtO1O11/sk8ox3bL8gXJsS48HpFEYXb+AMQ0YaWU3S1Uzc/gpeXewM8D5d3T6CKiH2WvKHB8bz6wIODc2lcM+/ZPcDwHzBNMFgooUIOJPlsOWkhv+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GW4dHtUW; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GW4dHtUW"
ARC-Seal: i=1; a=rsa-sha256; t=1784016405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S8pBkPs3DNwH2W6Lf3j81p4MKVDdUD/Tnj0z6+EM7zOl1Y/EhH3sIFoM4oJDpRdSD9KcoFhCZytT4l4LdnWi1JviW++Akic8191r61zzVaIWmBChCF9uo4biCP1ENyzilTdpcuwIqi5in54WTAS+Mkl+c/V646zCj29rDn5Th8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784016405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eMIPR0G3Z6CokuLR/14FmirRfZX7/FEoyaM9cRE8/lo=; 
	b=Kq9/QArfM6FPzgQPByAW4YWLp1+hzxtSc/1jEwRhDWmQhn34emCCEa+FlIYeMLUKFqZyZGqBvcFVSG7RQhnsyCip8B6FxzDEGIv1Q5oQMi2T4DATjqEF0/fWihFYp0xiYzpE7IfXsHGUrDHSKSqblcnHH1kPf0lqGbjdxTg2RJA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784016405;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=eMIPR0G3Z6CokuLR/14FmirRfZX7/FEoyaM9cRE8/lo=;
	b=GW4dHtUWmXGQa2hCJM+r04OV8BuJygMXQQIJKcJ+AwOxQjsz5lLyFvdWwPdj5q8N
	q7EPeboXIlbnftldfQroInVCMhMGkUSlIDz9nhcYUdWYmfMsW2kVg56FpTV/qjbSrGn
	kr7oEgScaSVcAC2gvnXIbKWmzcpmBqwsJXKM6Z9Q=
Received: by mx.zohomail.com with SMTPS id 1784016402626239.48063790002539;
	Tue, 14 Jul 2026 01:06:42 -0700 (PDT)
Message-ID: <8319395b-8e7f-4111-aa95-77970f261a7b@zohomail.com>
Date: Tue, 14 Jul 2026 16:06:32 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Restart port enumeration when a sibling adds
 the dport first
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>
References: <20260714020438.1822669-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260714020438.1822669-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227fbdc2ddd18e33df4f2a9abf0000053efeb6db03a6951506f1043bdb5f1d601f6b3b3d904780df2:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/14 10:04, Alison Schofield 写道:
> Endpoint probes can race while enumerating a shared switch. If a
> sibling probe adds the dport first, the losing probe finds the dport
> already present, gets -EBUSY, and fails to enumerate the endpoint.
>
> Treat this race the same as the existing port-created case by
> restarting the port walk, allowing it to find the existing dport
> and continue enumeration.
>
> This race was discovered while testing a cxl_test mixed-granularity
> topology, where twelve endpoints behind shared switches are probed in
> parallel during module load.
>
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

After deep diving into this issue and using your cxl_test 
mixed-granularity topology patchset to reproduce it. What I observed is 
a little bit different from the case you mentioned in v1, I can provide 
more details about that.

I believe it always happens with the log like "cxl_mem memX: probe with 
driver cxl_mem failed with error -16".

It will happen with the multiply switch levels topology like:

                            CXL host bridge

                               (hb dport 1)

                                       |

                              CXL switch 1

                              (sw1 dport 1)

                                       |

                              CXL switch 2

               (sw2 dport 1)       (sw2 dport 2)

                         |                           |

                endpoint 1             endpoint 2

When endpoint 1 probing is creating cxl switch 1 port by calling 
add_port_attach_ep(), it finally calls devm_cxl_create_port() for port 
creation, devm_cxl_create_port() is responsible for port creation and 
the given dport creation, in above topology, they are "CXL switch 1" 
port and "sw1 dport 1" creation. devm_cxl_add_port() is used for a port 
creation and probe_dport() is for a dport creation in 
devm_cxl_create_port(). But there is a small windows between these two 
function which the parent port device lock cannot protect. When 
devm_cxl_add_port() done, the newly added port is visible in CXL 
subsystem, at this point, if endpoint 2 probing observes cxl switch 1 
port, it will call add_port_attach_ep() for "CXL switch 2" port 
creation, in add_port_attach_ep(), it will use probe_dport() to create 
parent port's dport, in this example, parent port is "cxl switch 1" 
port, parent port dport is "sw1 dport 1". This flow triggers the problem.

endpoint 1 probing  endpoint 2 probing

------------------------------------------------------------

add_port_attach_ep() for switch 1 port

   # hold parent port device lock(HB port device lock)

   devm_cxl_create_port() for switch 1 port

     devm_cxl_add_port()

     # switch 1 port can be observed

              add_port_attach_ep() for switch 2 port

                # hold parent port device lock(switch 1 port device lock)

                cxl_find_dport_by_dev() for parent dport of switch 2 
port   # parent dport(sw1 dport 1) has not been added yet.

                probe_dport() for parent dport(sw1 dport 1) addition

                devm_cxl_create_port() for switch 2 port

                # release parent port device lock(switch 1 port device lock)

     # hold the added port device lock(switch 1 port device lock)

     probe_dport() for the given dport(sw1 dport 1) addition

     fails because the given dport has been added by endpoint 2 probing


I am not sure if the find_or_add_dport() part you mentioned in v1 can 
also trigger the same problem, my understanding is that 
find_or_add_dport() needs to hold the same parent_port/host device lock. 
Anyway, we all know enumeration flow is complicated, maybe I ignore some 
cases.

Besides, seems like there is another enumeration issue can be found by 
using your cxl_test mixed-granularity topology patchset, because 
sometimes my environment still misses some memdevs without above log 
after loading cxl_test with your fixup. But it may be another issue, I 
am trying to figure it out.

For this case, feel free to add

Tested-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


Ming

> ---
>
> Changes in v2:
> - Commit log: note that race is btw different dport add paths for the
>    same shared dport (Ming)
>
>   drivers/cxl/core/port.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..65f2d2f1eb00 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1749,8 +1749,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>   					     parent_dport, uport_dev,
>   					     dport_dev);
>   		if (IS_ERR(dport)) {
> -			/* Port already exists, restart iteration */
> -			if (PTR_ERR(dport) == -EAGAIN)
> +			/* Port or dport already exists, restart iteration */
> +			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
>   				return 0;
>   			return PTR_ERR(dport);
>   		}
>
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
