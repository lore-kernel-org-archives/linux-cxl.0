Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416137FF56
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282056; cv=none; b=aux7tQI321Ul8kvejG4oql3IIO7bYNUu/Yu3wuTu8qUSzXw8LLSTclUI+MCiM7MtdE8JKzAP3TShjP4c0kS0vEho8vCfUw4EdFagDxhjfpSfMPvO2TM6l5Eci5SzMtkGqhCBzaHEsK9fCmwfV9BDSL5DdSgdPWQnfkizTtK5qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282056; c=relaxed/simple;
	bh=Fbt5z3RlQX7uE5fPza9+n11jMRJS86/huzP2wYqLwxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G14CKArjlUdTgvvDz0KIBwXdTVZ9bs/Pr4wopCASHHAjpvGLPnz6LoFyZd9JViJa/gR+533zBihCPDfmsz/rkfNBACfYIf6p/nFwIfgA/OD6WLDFXwe0DryssFPYVGP1BRerHbS45pinb8L/3LFDPmjiKkDUYTMxWa5vGG2Hcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HumXSn0p; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HumXSn0p"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1106279085a.2
        for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776282054; x=1776886854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LDC8jcFDmTbSeuUhBTn6DAnyFWcoxjOsrPOPaR64HNI=;
        b=HumXSn0p5TKMA4dEtoS52dpG/QTr9RxyA+2JcFbjKCkIHbCeVyKF7BG2cRaA0gAv77
         aniIVEI052IH94Ow/wneSQyaHOMNe5DPmt/AdY3afhui4UEjuPcVxMXh1ku8nP6ChRSC
         A5Zo/DSomNDx7cOn40hC0jeTXbNwrz3Us9w9uI+kCukbq4jIBt5D/V/yFqrYTPtyKPil
         T34YLj6z7Ddyn6O9QJt9dwztda68l6XmnJyrFoD55dQOkyqlEX/A9wyPDp28XP0LTZc0
         YdrZq3q3P1NJMnuS/C8rTZG3QyQub5c7wELXAxSVv1BW2uoN0SKs6rvi3keakzn8uqI0
         iiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282054; x=1776886854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDC8jcFDmTbSeuUhBTn6DAnyFWcoxjOsrPOPaR64HNI=;
        b=C7y8MtD+5SD4evsgD6Z6KNP70vHmRssr/Fztb7Ok+SbQQNWFtak6iot4AXBAZgFscS
         K1yqq2+WNs8azEQjgWxt6rPyxhBglbFyjazdyggkH5s9+xWIil2G0KlRMMi+rvXfbGMO
         3KcVdRM/QW0SlKFUwDxbTSqOxJaBoCAyD6b/IVgu+H7TKS95T9sGfqlVzfYepPplF6de
         Jk/hNVesmAB0CFYwIaeKEWaOG0A+Z1j7Y1HA9aRDOwLgBzjZjz0Z8+kjMQ3ZM0xD2BKX
         9SlB8CN4s57Qx1UUdR+/edjkkbFGcY1VqiMJyoWEZzQ7cIpjr2hQUL2UFgdmDifdZr1n
         HSMg==
X-Forwarded-Encrypted: i=1; AFNElJ/qx9pPg0S+hu56lyIEG9hzPbS6HV4tMdOa4rjY7K1z2z5BqN22UnusdXfwg0cQeEpCRaUEMZ3YcH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXqbUwjGSAGvUwK6T3Xv0V03CguOH+dpjn73VUVhOQV8kfXmP
	vj99yT7Z3th3nmpYHzudrggFw809w7/YN77wsuZZh89RUp8k5vxmSHqUAwFntVr0kpw=
X-Gm-Gg: AeBDiesDHBKLc5Z4ujIkvt3hNj8lQ9PnrTAHIlkaxxygIeqymHVV8fDhLY17M0Q7VE7
	2FN2QgvxYSDgv22ifLXekChm1oJOIgb4YwkdVxrbXtBQB+qoECzPNIas4URuNvmtrvRZ9nshWf4
	kPivlR3r/vrfflxWeD4bdO4LcK06zofj6V2t962/zyBQqmr7Xw4ePUrkbwwQuPci0MDURihh+P/
	twsQOGqKe2ZfjbTyIEJvPRUzYToZsbyUgRjS8tkUJv4wT0UfV8BwAV/9PPtRHs3N1/HvJ88d/A/
	M6wbPOreC9jXFaDbkfXsYYlycE8wf/IGgHzYMlEcUtiFmxMYVK5GTZqOraIHYLSP1rAwns0yJu6
	iB4FKuHqG4mLh72ptmZxe1jIfjFHMYMCJYny7ttMAHCu2CKj5kIyKxDR0rwOWOFKPX7pj9IEg4t
	uhO0PNEv52wTi1OtZIA/BGgSvie1nG8HuQeD4EnTYmcj9aFM2hTEpfav+LUcoPn6ERVg8Ef7PBP
	xT1iHzD9PiMW8MhkeRD2rY=
X-Received: by 2002:a05:620a:2849:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8ddcd504c7emr3103848285a.25.1776282053498;
        Wed, 15 Apr 2026 12:40:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-28-184-130.washdc.fios.verizon.net. [108.28.184.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2926001sm186837485a.34.2026.04.15.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:40:52 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:40:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	djbw@kernel.org
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <ad_pwaRORHRP5YMM@gourry-fedora-PF4VCD3F>
References: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F>
 <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F>
 <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
 <ad-qSB4oL5D3S-ht@casper.infradead.org>
 <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
 <CAJnrk1Z+uNjn+BcmpciqPZhxYXEJ5Zgh=uNCxt17WTkdOubbog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z+uNjn+BcmpciqPZhxYXEJ5Zgh=uNCxt17WTkdOubbog@mail.gmail.com>

On Wed, Apr 15, 2026 at 10:12:54AM -0700, Joanne Koong wrote:
> On Wed, Apr 15, 2026 at 8:32 AM Gregory Price <gourry@gourry.net> wrote:
> >
> > My initial take is that it's a real concern a "bug" in a BPF program
> > could let userland map arbitrary memory into userland page tables, and
> > such an extension would not be a quick fix to the FAMFS problem.
> 
> If you're concerned about arbitrary addresses in the bpf path, you
> should be equally concerned about the FUSE_GET_FMAP path that's in
> this series, because they're functionally identical. The kernel trusts
> userspace-provided addresses in both cases. If that's acceptable for
> this series then it's acceptable for bpf too. You can't reject bpf on
> security grounds without also rejecting the current approach.
> 

To be clear, i'm not rejecting it.  I'm saying (!) that's something that
needs a careful look.

It's a novel interaction and a new ops structure. I don't think it's in
any way unfair to point out there will (and should) be questions outside
the scope of FAMFS.

> Please take a look at the famfs bpf program [1] and compare that to
> the logic in patch 6 in this series [2]. In both cases, iomap->addr
> gets set to the address that was earlier specified by the userspace
> famfs server. In the non-bpf path, the userspace server passes this
> address through a FUSE_GET_FMAP request. In the bpf path, the
> userspace server passes this address by updating the bpf hashmap from
> userspace. There is no functional difference. Also btw, this is one of
> the cases that I was referring to about the bpf path being more
> helpful - in the bpf path, we avoid having to add a FUSE_FMAP opcode
> to fuse (which will be used by no other server) and famfs gets to skip
> 2 extra context-switches that the FUSE_FMAP path otherwise entails.
> 

The question isn't about the functional differences between the FAMFS
static code or a BPF blob doing the same thing - the question is what
the new ops structure introduces for the general case that wasn't
there before.

We have to reason about the BPF extension separately from the context of
FAMFS - as it's a general interface now (forever :P).

~Gregory
