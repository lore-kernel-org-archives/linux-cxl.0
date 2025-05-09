Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1F1FDE19;
	Fri,  9 May 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746790298; cv=none; b=SfHlSrT6BBwMrvPV2PgadBcqDHS0Zz2yoc54kBKTzPEKIBcpmek7dppjx8VV6kRLakCN3cACRCAB8FK5WOarxt2maXkm7BSW9ugfuVLuM6ga/kP3q/quVUhmxxj26fVKWlw4MIYw5zJu/Pe6ncsnkU/nEHx+0cIMiYpMvaNDj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746790298; c=relaxed/simple;
	bh=AImcA9QxPgiogvxeRWAYAww0+ErJYgYYwZD28UNgqYA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdMNg7qguQWM51pXveixeFKj6HF/07tqCtT+bK+tGcjz2/xVhtTpFeoSlo0zvhFE/LLpLzQBC+Wl4zpEF4kRVhmxL3n+i+TyNcFAgTGri9Yzvx7wM5dHDwtnfIZpKYrA3kb20tYLCyFQO1Ng51RuDEHtKZZGq8l8azGhrh9WHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zv6Jf47HPz6K9qv;
	Fri,  9 May 2025 19:31:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A6087140519;
	Fri,  9 May 2025 19:31:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 May
 2025 13:31:33 +0200
Date: Fri, 9 May 2025 12:31:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Rakie Kim <rakie.kim@sk.com>, <joshua.hahnjy@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	"Keith Busch" <kbusch@kernel.org>, Jerome Glisse <jglisse@google.com>
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in
 weighted interleave
Message-ID: <20250509123131.0000051b@huawei.com>
In-Reply-To: <aBzJ42b8zIThYo1X@gourry-fedora-PF4VCD3F>
References: <aBuMet_S1ONS1pOT@gourry-fedora-PF4VCD3F>
	<20250508063042.210-1-rakie.kim@sk.com>
	<aBzJ42b8zIThYo1X@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 8 May 2025 11:12:35 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, May 08, 2025 at 03:30:36PM +0900, Rakie Kim wrote:
> > On Wed, 7 May 2025 12:38:18 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > The proposed design is completely optional and isolated: it retains the
> > existing flat weight model as-is and activates the source-aware behavior only
> > when 'multi' mode is enabled. The complexity is scoped entirely to users who
> > opt into this mode.
> >   
> 
> I get what you're going for, just expressing my experience around this
> issue specifically.
> 
> The lack of enthusiasm for solving the cross-socket case, and thus
> reduction from a 2D array to a 1D array, was because reasoning about
> interleave w/ cross-socket interconnects is not really feasible with
> the NUMA abstraction.  Cross-socket interconnects are "Invisible" but
> have real performance implications.  Unless we have a way to:

Sort of invisible...  What their topology is, but we have some info...

> 
> 1) Represent the topology, AND
> 2) A way to get performance about that topology

There was some discussion on this at LSF-MM.

+CC Keith and Jerome who were once interested in this topic

It's not perfect but ACPI HMAT does have what is probably sufficient info
for a simple case like this (2 socket server + Generic Ports and CXL
description of the rest of the path), it's just that today we aren't exposing that
to userspace (instead only the BW / Latency from a single selected nearest initiator
/CPU node to any memory containing node).

That decision was much discussed back when Keith was adding HMAT support.
At that time the question was what workload needed the dense info (2D matrix)
and we didn't have one.  With weighted interleave I think we do.

As to the problems...

We come unstuck badly in much more complex situations as that information
is load free so if we have heavy contention due to one shared link between
islands of nodes it can give a very misleading idea.

  [CXL Node 0]                         [CXL Node 2]
       |                                    |
   [NODE A]---\                    /----[NODE C]
               \___Shared link____/ 
               /                  \
   [NODE B]---/                    \----[NODE D]
       |                                   |
  [CXL Node 1]                         [CXL Node 3]

In this from ACPI this looks much like this (fully connected
4 socket system).

  [CXL Node 0]                         [CXL Node 2]
       |                                    |
   [NODE A]-----------------------------[NODE C]
       |   \___________________________   / | 
       |    ____________________________\/  |  
       |   /                             \  | 
   [NODE B]-----------------------------[NODE D]
       |                                   |
  [CXL Node 1]                         [CXL Node 3]

In the first case we should probably halve the BW of shared link or something
like that. In the second case use the full version. In general we have no way
to know which one we have and it gets way more fun with 8 + sockets :)

SLIT is indeed useless for anything other than what's nearest decisions

Anyhow, short term I'd like us to revisit what info we present from HMAT
(and what we get from CXL topology descriptions which have pretty much everything we
might want).

That should put the info in userspace to tune weighted interleave better anyway
and perhaps provide the info you need here. 

So just all the other problems to solve ;)

J

> 
> It's not useful. So NUMA is an incomplete (if not wrong) tool for this.
> 
> Additionally - reacting to task migration is not a real issue.  If
> you're deploying an allocation strategy, you probably don't want your
> task migrating away from the place where you just spent a bunch of time
> allocating based on some existing strategy.  So the solution is: don't
> migrate, and if you do - don't use cross-socket interleave.
> 
> Maybe if we solve the first half of this we can take a look at the task
> migration piece again, but I wouldn't try to solve for migration.
> 
> At the same time we were discussing this, we were also discussing how to
> do external task-mempolicy modifications - which seemed significantly
> more useful, but ultimately more complex and without sufficient
> interested parties / users.
> 
> ~Gregory
> 

