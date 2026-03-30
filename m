Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63F23A984;
	Mon, 30 Mar 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840220; cv=none; b=Vi//7DSvVn4xKu7+NiThlS0WL82IHE//catBkWxrQptBSrWu/K/d8b4Mg8Njjtyqa1sKy/naDSTVljPoe7gIrzU6vCR4W1Jzv5ksm1BuIZz71Tb66iI9An1vKHKYZTnpu/a+6Hz+T6sUbZLYNI6SN6YxrNhz4lJ/ESmIZC+VdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840220; c=relaxed/simple;
	bh=Bxa2u6BunKbtk63BBWJI9ftDPH+cw8jJluuL4pM286c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNwWb0SFo5LNMRn4RPtl8mrork8FrhtxNJGVVuGyW9uh/GUPVIc9ITdsftEL7TcuRjQjxVa5qznbu7YriDd5kxzagrw2i8JC+M5HV/inVIeGmv8F5tJjuOOteX5KEZcNFG6jxuKDTnn4qPlBYKt+MzF0mIB9xBjq+Bstf+qz1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-56-69c9e9941607
From: Rakie Kim <rakie.kim@sk.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Keith Busch <kbusch@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce socket-aware weighted interleave
Date: Mon, 30 Mar 2026 12:09:55 +0900
Message-ID: <20260330031000.372-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <67c5b4a4-fdee-425c-8383-5c9c2f32227c@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnoe6UlyczDaZ8kbCYs34Nm8XdxxfY
	LHbdCLGYPvUCo8WJm41sFqtvrmG0eL71F6PFz7vH2S32P33OYrFq4TU2i+Nb57FbTDp0jdFi
	e8MDdovzs06xWFzeNYfN4t6a/6wWJ2etZLH41idtcb/PweLI+u1MFpMvLWCzmN3Yx2hxa8Ix
	JovVazIsZh+9x+4g6bFz1l12jwWbSj262y6ze7QcecvqsXjPSyaPTas62Tw2fZrE7nFixm8W
	j50PLT16m9+xeXx8eovFY+rseo/1W66yeJxZcITd4/MmuQD+KC6blNSczLLUIn27BK6MtVcu
	MhdskKq4fWgKewPjU5EuRk4OCQETiRMrljB2MXKA2VMPqIGYbAJKEsf2xoBUiAioStxf/5it
	i5GLg1ngA6vEy7YOFpCEsECGxITl/5lBbBagopbpv1lBbF4BY4nF9z4xQozXlFi38RZYPaeA
	rcTRmb1gcSEBHolXG/YzQtQLSpyc+QSshllAXqJ562xmiN6f7BIfXlhB2JISB1fcYJnAyD8L
	ScssJC0LGJlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgRG7bLaP9E7GD9dCD7EKMDBqMTDa8B2
	MlOINbGsuDL3EKMEB7OSCG/39GOZQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5ak
	ZqemFqQWwWSZODilGhiFKw/0JOkwhJoo/nxR2rzzbqeIA/ObLfOWJ53gjDA6+THXtKvt75dK
	5wcrCqVOXg5P+BTJtvdoxgcGb4VHG+QN1ZW31l5Mznnj+0t9wwLrxB1CQif252V8O5P+dn5o
	d4RxRnH0pu/tmz232QYyrnIpOGWb0iD2MeCvaMW8pa72Dmd8dz71WqbEUpyRaKjFXFScCAAY
	3iLn1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYQCG+3bOzjmuLc7WoINS0eimkFmafUKF9KcP6YdBFIWQQ09tOKds
	Ks4yFUVMcZi61M1sXuii5rXlBc1Y3iZh2myk4szLNDXvIaWJOSPw38P7PP9eChO14a6UXBnF
	qpRShYTg4bz8E0Gncmcscq+qMhIWVlcScGSij4DNX6/D3lwDAfN0fQB2DyYRsGKwEsBp0zqA
	v0e6SLg6NYfBNsc0DsuLbQTsMhWRMNtsA/DDUwsXNiR+I+EnfQ8Orc2FBLRXbnGhRf8Kh2ta
	Nziq9Ydm2zQXtlc3cGDOZyMBDUlaAIeyOjmwolIGN96+3J467KT/IdSkHyGRsS4aZaRaSZTS
	Ps9FpS0zHFRX/ohAdSvZJOrO38BR05gfykxeINCyYwhHa8MIlX5f4iCdIQFVv/mCo4/GdjJQ
	eJt3IZRVyGNY1elLwTzZ64F+LLLGNXbYnEsmAoc4HVAUQ/swuvfHnUjQEqazNSgduFBi+hgz
	Wj1BpAMehdFLXGYmNQ13iv20jMl6sYU5Gd+OUvI2uE4W0N5MqX0FOJmh3Zmq2qGd3oW+yHQU
	ZO7sIprPzNa0gX+9kLEUTO40GH2YSTYZsCzA1+9S+l3KCDjlQCxXxoRL5YpznuowmUYpj/UM
	iQivA9u3Po//87gR/LReMQOaAhK+wIuwyEVcaYxaE24GDIVJxIKMvE65SBAq1cSxqog7qmgF
	qzYDNwqXHBAE3GSDRfQ9aRQbxrKRrOq/5VAurokA1bSO+lp1thsn7cJ343u9gtMM+hDtLCen
	xFY/17XVPRaZdbl2MfBqyYOW1poj/cDH+GwzXnzX7/6vPe6rmiJmuTFyMfEJf55dO5hSP3V0
	AWVujgvhXNy1gBir+WGzZHLVUZyE7ROXJfn1hJp8EwZ6vc+TtxJ+nI0YWC/TDnpIcLVMesYD
	U6mlfwFvecJ50gIAAA==
X-CFilter-Loop: Reflected

On Thu, 26 Mar 2026 14:41:32 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> 
> 
> On 3/26/26 1:54 AM, Rakie Kim wrote:
> > On Wed, 25 Mar 2026 12:33:50 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> >> On Tue, 24 Mar 2026 14:35:45 +0900
> >> Rakie Kim <rakie.kim@sk.com> wrote:
> >>
> >>> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> <--snip-->
> 
>  
> > Hello Jonathan,
> > 
> > Thank you for the deep insight into the HMAT parser code. As you
> > mentioned, considering the current state where node 1 is still
> > registered as the initiator in sysfs despite the flag being 0, it
> > seems highly likely that the kernel parser logic is not handling
> > this specific situation gracefully.
> > 
> >>
> >>> Because both HMAT and sysfs are exposing abnormal values, it was
> >>> impossible for me to determine the true socket connections for CXL
> >>> using this data.
> >>>
> >>>>>
> >>>>> Even though the distance map shows node2 is physically closer to
> >>>>> Socket 0 and node3 to Socket 1, the HMAT incorrectly defines the
> >>>>> routing path strictly through Socket 1. Because the HMAT alone made it
> >>>>> difficult to determine the exact physical socket connections on these
> >>>>> systems, I ended up using the current CXL driver-based approach.  
> >>>>
> >>>> Are the HMAT latencies and bandwidths all there?  Or are some missing
> >>>> and you have to use SLIT (which generally is garbage for historical
> >>>> reasons of tuning SLIT to particular OS behaviour).
> >>>>   
> >>>
> >>> The HMAT latencies and bandwidths are present, but the values seem
> >>> broken. Here is the latency table:
> >>>
> >>> Init->Target | node0 | node1 | node2 | node3
> >>> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
> >>> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
> >>
> >> Yeah. That would do it...  Looks like that final value is garbage.
> 
> Hi Rakie,
> So I talked to the Intel BIOS folks and apparently for devices that are not hot-plugged (with memory ranges provided in SRAT), those HMAT values are the value for end to end and not just CPU to Gen Port. That's why they look so much bigger. So there are couple things we'll have to consider:
> 1. Make sure that Intel, AMD, and ARM HMATs are all created the same way and this is the agreed on way to do this. Hopefully someone from AMD and ARM vendors can comment. We all should get on the same page for the CXL kernel code to work properly.
> 
> 2. Add code in the CXL driver to detect whether the range is in SRAT and then skip the end to end perf calculation if that is the case. 
> 
> DJ
> 

Hello Dave,

Thank you for reaching out to the Intel BIOS folks directly. Knowing
that the HMAT values represent end-to-end latency completely explains
why the numbers seemed so disproportionately large.

I strongly agree with your two points. Establishing a consensus
across all architecture vendors (Intel, AMD, ARM) on how these
values are interpreted is crucial. Also, adding logic to the CXL
driver to detect the SRAT presence and skip redundant calculations
sounds like the exact right direction.

I have posted the detailed SRAT and HMAT information at the link below:
https://lore.kernel.org/all/20260330025914.361-1-rakie.kim@sk.com/

Rakie Kim

> 
> <--snip-->
> 
