Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3467258CCA;
	Mon, 12 May 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038211; cv=none; b=HATEQyXLfaRKFAXx49kUQZ+hf89pAogn1iqy7Uy8KGHRewwy91wwg/3JycGjEtIEkqgAGaGQwE8CbLGdC9+aELmUvd2qoj+4fHxV/baKIUmYOX0H89nojtMartWpUudrZxjah7yQgBDq6hPqPOHPajxnVLpd30I4lp2HEYGk2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038211; c=relaxed/simple;
	bh=1Z8x8vzMJPRdGcVco8GbYGcxczYtEYM3hxvfcdV4gTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3Q/1MBHUYzNyzJ/FcbLzivGgDSo+i2KlUCeciAtccu309YT5Lt5h5xPMyeUs4KQw7NvUMLsmuDzY4oV+dBStBs4nrZ5cJIWq87Wo27truwdPpZWHmso/mI/L/fqpuwJsMvYMOWwIEXGHGOYc93Vc5+5nEOjoRiaD1JTWIy4pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-9f-6821affd1420
From: Rakie Kim <rakie.kim@sk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rakie Kim <rakie.kim@sk.com>,
	joshua.hahnjy@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	"Keith Busch" <kbusch@kernel.org>,
	Jerome Glisse <jglisse@google.com>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Mon, 12 May 2025 17:23:14 +0900
Message-ID: <20250512082320.274-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250509123131.0000051b@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe7f9YoZBqs2SljMWb+GzWL61AuM
	Fj/vHme3+Hl4B4vFqoXX2CyOb53HbjHp0DVGi/OzTrFYXN41h83i3pr/rBar12Q4cHvsnHWX
	3WPBplKP7rbL7B4tR96yeize85LJY9OqTjaPTZ8msXucmPGbxWPnQ0uPz5vkAriiuGxSUnMy
	y1KL9O0SuDLuN7AX3NSr+NbylrWBsUepi5GTQ0LARGLO6VVsMPaDmx3sXYwcHGwCShLH9saA
	hEUEjCTe3ZjE2MXIxcEsMJ9Z4tqMZawgCWGBBIlT8y4xg9gsAqoS63tXsID08goYSyyb7gMx
	UlOi4dI9JhCbU8BQ4lbjUkYQW0iAR+LVhv1gNq+AoMTJmU9YQGxmAXmJ5q2zmUF2SQh8Z5N4
	vH47O8QgSYmDK26wTGDkn4WkZxaSngWMTKsYhTLzynITM3NM9DIq8zIr9JLzczcxAsN/We2f
	6B2Mny4EH2IU4GBU4uFNWKuQIcSaWFZcmXuIUYKDWUmEdyqDfIYQb0piZVVqUX58UWlOavEh
	RmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxiV6YXsuKLd+ZPSeb/acofBpgtUd2ZV+
	0ZFN5tMcNsR+DTkQeyD1bHCmeWmNKHOJSnS+QrvHvgPch2ddiJXZrCK2p3zP3kf6m62Wrgma
	3hl4eJ51Q4tKeLf10T3TI3e+WtvlI81od6iiMTP0W1OW4QI78eQl//in9ti7P2EwLf93f9q0
	d7/DlViKMxINtZiLihMBWRm1/HsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS/fvesUMg86TPBZz1q9hs5g+9QKj
	xc+7x9ktPj97zWzx8/AOFotVC6+xWRzfOo/dYtKha4wWh+eeZLU4P+sUi8XlXXPYLO6t+c9q
	cejac1aL1WsyLH5vW8HmwO+xc9Zddo8Fm0o9utsus3u0HHnL6rF4z0smj02rOtk8Nn2axO5x
	YsZvFo+dDy09vt328Fj84gOTx+dNcgE8UVw2Kak5mWWpRfp2CVwZ9xvYC27qVXxrecvawNij
	1MXIySEhYCLx4GYHexcjBwebgJLEsb0xIGERASOJdzcmMXYxcnEwC8xnlrg2YxkrSEJYIEHi
	1LxLzCA2i4CqxPreFSwgvbwCxhLLpvtAjNSUaLh0jwnE5hQwlLjVuJQRxBYS4JF4tWE/mM0r
	IChxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJ
	ERjyy2r/TNzB+OWy+yFGAQ5GJR5eCX/FDCHWxLLiytxDjBIczEoivFMZ5DOEeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGM1e8S8xT/iq8tU3IOfkd4v8
	zHQ7jxa9Nkflv0+tpl1ONapJLPZe1bElYUtwoWRNIb/Eww3ZZefWJYqVn8pk2tn39/SuY6HO
	cpMjWfZdZo/YbrV7zbSWHYGXwgXvsesePZrzn/HEnYum3CeC2UwzP0qW199sTSrM/HQ5/1y5
	15bq9PllPK8DlViKMxINtZiLihMB6DnNq3UCAAA=
X-CFilter-Loop: Reflected

On Fri, 9 May 2025 12:31:31 +0100 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> On Thu, 8 May 2025 11:12:35 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, May 08, 2025 at 03:30:36PM +0900, Rakie Kim wrote:
> > > On Wed, 7 May 2025 12:38:18 -0400 Gregory Price <gourry@gourry.net> wrote:
> > > 
> > > The proposed design is completely optional and isolated: it retains the
> > > existing flat weight model as-is and activates the source-aware behavior only
> > > when 'multi' mode is enabled. The complexity is scoped entirely to users who
> > > opt into this mode.
> > >   
> > 
> > I get what you're going for, just expressing my experience around this
> > issue specifically.
> > 
> > The lack of enthusiasm for solving the cross-socket case, and thus
> > reduction from a 2D array to a 1D array, was because reasoning about
> > interleave w/ cross-socket interconnects is not really feasible with
> > the NUMA abstraction.  Cross-socket interconnects are "Invisible" but
> > have real performance implications.  Unless we have a way to:
> 
> Sort of invisible...  What their topology is, but we have some info...
> 
> > 
> > 1) Represent the topology, AND
> > 2) A way to get performance about that topology
> 
> There was some discussion on this at LSF-MM.
> 
> +CC Keith and Jerome who were once interested in this topic
> 
> It's not perfect but ACPI HMAT does have what is probably sufficient info
> for a simple case like this (2 socket server + Generic Ports and CXL
> description of the rest of the path), it's just that today we aren't exposing that
> to userspace (instead only the BW / Latency from a single selected nearest initiator
> /CPU node to any memory containing node).
> 
> That decision was much discussed back when Keith was adding HMAT support.
> At that time the question was what workload needed the dense info (2D matrix)
> and we didn't have one.  With weighted interleave I think we do.
> 
> As to the problems...
> 
> We come unstuck badly in much more complex situations as that information
> is load free so if we have heavy contention due to one shared link between
> islands of nodes it can give a very misleading idea.
> 
>   [CXL Node 0]                         [CXL Node 2]
>        |                                    |
>    [NODE A]---\                    /----[NODE C]
>                \___Shared link____/ 
>                /                  \
>    [NODE B]---/                    \----[NODE D]
>        |                                   |
>   [CXL Node 1]                         [CXL Node 3]
> 
> In this from ACPI this looks much like this (fully connected
> 4 socket system).
> 
>   [CXL Node 0]                         [CXL Node 2]
>        |                                    |
>    [NODE A]-----------------------------[NODE C]
>        |   \___________________________   / | 
>        |    ____________________________\/  |  
>        |   /                             \  | 
>    [NODE B]-----------------------------[NODE D]
>        |                                   |
>   [CXL Node 1]                         [CXL Node 3]
> 
> In the first case we should probably halve the BW of shared link or something
> like that. In the second case use the full version. In general we have no way
> to know which one we have and it gets way more fun with 8 + sockets :)
> 
> SLIT is indeed useless for anything other than what's nearest decisions
> 
> Anyhow, short term I'd like us to revisit what info we present from HMAT
> (and what we get from CXL topology descriptions which have pretty much everything we
> might want).
> 
> That should put the info in userspace to tune weighted interleave better anyway
> and perhaps provide the info you need here. 
> 
> So just all the other problems to solve ;)
> 
> J

Jonathan, thank you very much for your thoughtful response.

As you pointed out, ACPI HMAT and CXL topology descriptions do contain
meaningful information for simple systems such as two-socket platforms.
If that information were made more accessible to userspace, I believe
existing memory policies could be tuned with much greater precision.

I fully understand that such detailed topology data was not widely
exposed in the past, largely because there was little demand for it.
However, with the growing complexity of memory hierarchies in modern
systems, I believe its relevance and utility are increasing rapidly.

I also appreciate your point about the risks of misrepresentation in
more complex systems, especially where shared interconnect links can
cause bandwidth bottlenecks. That nuance is critical to consider when
designing or interpreting any policy relying on topology data.

In the short term, I fully agree that revisiting what information is
presented from HMAT and CXL topology and how we surface it to
userspace is a realistic and meaningful direction.

Thank you again for your insights, and I look forward to continuing the
discussion.

Rakie

> 
> > 
> > It's not useful. So NUMA is an incomplete (if not wrong) tool for this.
> > 
> > Additionally - reacting to task migration is not a real issue.  If
> > you're deploying an allocation strategy, you probably don't want your
> > task migrating away from the place where you just spent a bunch of time
> > allocating based on some existing strategy.  So the solution is: don't
> > migrate, and if you do - don't use cross-socket interleave.
> > 
> > Maybe if we solve the first half of this we can take a look at the task
> > migration piece again, but I wouldn't try to solve for migration.
> > 
> > At the same time we were discussing this, we were also discussing how to
> > do external task-mempolicy modifications - which seemed significantly
> > more useful, but ultimately more complex and without sufficient
> > interested parties / users.
> > 
> > ~Gregory
> > 
> 
> 
