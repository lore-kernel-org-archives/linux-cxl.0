Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99E2B9B9
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925401; cv=none; b=cDKXEVnb7ZzSyrJRQACstqCsrd8DDv0rBXgomeI/hCqohtb8n+YWlT50eZzUhVtb+1XJzoUOL8pmfur48zkSzHAqE768x8zcfaekYYEh1ldZ3prE+4ef3u//bc0w1+iOVd0PbwzueXKhhqiBZwdM9P5va8xfGxJNvhaqcEZ8C/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925401; c=relaxed/simple;
	bh=iCR1dmrjrNFllGLWPQBgfFUzKWX/36TLqyq/iuTiqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF9o/kgpvN6Dcdhh7WmhfxLqftQTMJupVCQ6K6fXpFG7dTg2zFBoxswPDSkIsxPQjb89yjzXW7RuMXevf+qe5gRBckVnl37gv+jtQNMZamjR2ABn5cyCcgORSOjBVcxnSXPbr13ZeDc8+4PrS/4491XsHQo8nrDIJ7zlY/6w5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-3e-67a5e5507558
Date: Fri, 7 Feb 2025 19:49:47 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250207104947.GB35103@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnkW7A06XpBqufiVtM7DGw+Hn3OLvF
	+VmnWCzurfnParHv9V5mi98/5rA5sHnsnHWX3aO77TK7x+YVWh6bPk1i95h8Yzmjx+dNcgFs
	UVw2Kak5mWWpRfp2CVwZ7cvfsxSs5q24sHErawPjDq4uRk4OCQETiZNLn7B3MXKA2VN+JoOE
	WQRUJPbt+84IYrMJqEvcuPGTGaREREBVou2KexcjFwezwCNGiYsHljCBxIUF0iTe/vADMXkF
	LCS6ztmBlAgJTGWSuD1hIhvIGF4BQYmTM5+wgNjMAloSN/69BGtlFpCWWP6PAyTMKWAmsWLt
	T7ASUQFliQPbjjOBzJEQ2MMm0dvxjRHiYkmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68s
	NzEzx0QvozIvs0IvOT93EyMwpJfV/onewfjpQvAhRgEORiUe3oQDS9KFWBPLiitzDzFKcDAr
	ifBOWQMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwDh1
	85tLv99uMuhf0ztjtvuma1UNicI3p4mLJ+3v1PN8JhSrcWL1D6vmKW+vXzCIPW9zk62YlXmV
	Sobuv7Awea6+rM0Ol8pLag7HlS438jhzVDroTOqM827JDr2T9/7vnZP/xKHS4sDtZy/y0sLY
	ogy2X/U2VH87K9Hbcd8bWR5etTcpInt6zyuxFGckGmoxFxUnAgBGX633ZQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXC5WfdrBvwdGm6QXsDn8XEHgOLn3ePs1t8
	fvaa2eLw3JOsFudnnWKxuLfmP6vFvtd7mS1+/5jD5sDhsXPWXXaP7rbL7B6bV2h5bPo0id1j
	8o3ljB7fbnt4LH7xgcnj8ya5AI4oLpuU1JzMstQifbsEroz25e9ZClbzVlzYuJW1gXEHVxcj
	B4eEgInElJ/JXYycHCwCKhL79n1nBLHZBNQlbtz4yQxSIiKgKtF2xb2LkYuDWeARo8TFA0uY
	QOLCAmkSb3/4gZi8AhYSXefsQEqEBKYySdyeMJENZAyvgKDEyZlPWEBsZgEtiRv/XoK1MgtI
	Syz/xwES5hQwk1ix9idYiaiAssSBbceZJjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9Yqz
	MyrzMiv0kvNzNzECQ3ZZ7Z+JOxi/XHY/xCjAwajEw5twYEm6EGtiWXFl7iFGCQ5mJRHeKWuA
	QrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYwLzS66163n
	YDtwQST31/vjy9bdUzk2c2GnH8+pTVMtJIT2y87a3zFx3bT691uqaqrbAvJ4t7+ZGZpwbnFy
	7QXX3iu2nHIJD2o89160uLB/e7+E+AOeiDsnWmdf+3U6epJfM/Omlpu5eUx6ciclbhTGvl69
	48jkd5aPUnRTvR38mVVFbYM9/rYosRRnJBpqMRcVJwIAduQ4dVUCAAA=
X-CFilter-Loop: Reflected

On Fri, Feb 07, 2025 at 04:54:10AM -0500, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 06:34:43PM +0900, Honggyu Kim wrote:
> > On 2/7/2025 5:57 PM, Gregory Price wrote:
> > 
> > > The default kernel stack size is like 16kb.  You'd need like 100,000
> > > threads to eat up 1.5GB, and 2048 threads only eats like 32MB.
> > > 
> > > It's not an interesting amount of memory if you have a 20TB system.
> > 
> > The amount might be small, but having those data in slow tier can
> > make performance degradation if it is heavily accessed.
> > 
> > The number of accesses isn't linearly corelated to the size of the
> > memory region.
> > 
> 
> Right, I started by saying:
> 
> [CXL is] "generally not fit for kernel use"
> 
> I have the opinion that CXL memory should be defaulted to ZONE_MOVABLE,
> but I understand the pressure on ZONE_NORMAL means this may not be
> possible for large capacities.

Just to clarify, for moderate capacities where ZONE_NORMAL in DRAM
covers the whole memory, it's not a big issue since the easiest solution
would be to place kernel objects in DRAM's ZONE_NORMAL and not allow
ZONE_NORMAL in non-DRAM.  No objection on it.

For large capacities, kernel object migratability might be a must.

For capacities between moderate and large, kernel object migratibility
or allowing ZONE_NORMAL in non-DRAM, or something better idea, would
help to reduce ZONE_NORMAL cost.

I'm adding my opinion with the last two cases in mind.

	Byungchul

> I don't think the solution is to make kernel memory migratable and allow
> kernel allocations on CXL.
> 
> There's a reason most kernel allocations are not swappable.
> 
> > Thanks,
> > Honggyu
