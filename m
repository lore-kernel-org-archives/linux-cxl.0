Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8E1C5F11;
	Mon, 30 Mar 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840640; cv=none; b=lQ4fr2UDJlc6arPt6VJ5ibW6xPhBi0uHDnG+uGNj9+vdGdmHrrvFu+Ash0TB4pzn1A5f4X6U/NXR9StdpGxsiplkglXZwtb1jVWm8hY9WtxsHp5QQLmKJJGi4bDkprRyLaIDQjc7dkkqK7JY71EKzvty34FM933a2viCulLEpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840640; c=relaxed/simple;
	bh=vE4JByYsBBPOb3u2zHeDKvgrj1pjCsv0+lqVHAIS9+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr6AkYGF9XwZBo3Q34lAHVzpCVd7ivaayn2cFG83HgB2psrpxrENEOsCqFGZYEBjUEvBXUKjrWg7jA2IdHAyoF6AhMUGrvomwdMYghouIZEkgcvvf1vXW9MGT7sETOFs2q6iYKkR1Fq2kCeQwzKCkpWDTJUbF1mfzQrqn27p02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-5e-69c9eb386bfb
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
Date: Mon, 30 Mar 2026 12:17:01 +0900
Message-ID: <20260330031710.383-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <9d672ece-e67c-47ff-9978-db405c939f67@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUhTYRTGebe7e6/L4W0a3jkqHJQpaZaKr1AhRPFCEEJBoPYx2sUNtynz
	OygVQ0priLpWm8VEc+WGq5X4kWGO+THRHI7EKdPEmZgYukpKDXOa4H8Pz/N7zjlwSDbfjoWR
	MmUuo1KK5SKci3GXAuujkxYdsljjcVhnMePQM+vEYef4FajVOAEccJfi0OQ2AzjfugbgH08/
	Abvn5jHYXD+Gw/7W5wSsto0B2FbyhYAjukEMujrrcDhl3uRAh+4VBlfVQjitToZ2SxsL1owa
	cKgvVQM4UdXHgiazFOp7p4hkAerQeQhksOahynIXge7ZlziooWuBhazND3Bk9VUTaODJOoY6
	ZpLQo7LvOFqZm8CQRl+MLO8+Y2jIYCfQD+uhlKBU7mkJI5flM6oTZ29ypYN1nVi2TlDo1WvY
	JcAdXAECSJqKpzW/yvBdrTMNERWAJHFKRPd9SPfbIdQRetoyu4VwSTa1zKEXyu9j/iCYktJV
	xk22X2NbkNbk2PZ5VBy9tFzL2pkZSbe8mdj2A6gzdOOsC/g1nwqkv73uBjv8ftrx1LvNsKnD
	dFmrnu1fRlN/Cdpb6v1/nIDueTmOVYEg3Z6Obk/HAFjNgC9T5ivEMnl8jLRIKSuMuZWlsIKt
	3zbd2UhrBz7nZRugSCAK5MXiDhmfI87PKVLYAE2yRSG8Sm2fjM+TiItuM6qsG6o8OZNjA0IS
	E4XyTq0WSPhUhjiXyWSYbEa1m7LIgLASkNDWoBsraH+rVdqN6jBfhOHh47hPpoQWb23qxcRr
	aVREwfDvr11yRVT6+bXJ3jzfvguTH68LM1TCkfehntClGSk6OJpytbhkTiVUvHBPRy/aUERl
	3c+GzPWjjXfrm45lPQuoda4MF00eWHWVG3rOXYoM7zOGKBKjBOE1I5INjwjLkYpPRrFVOeJ/
	MUMk/tcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRyHeXfOzjkuR8cpeLxQssjIyLSU3rTML9WLnyQEIQ0demrDqWPz
	GmQzxXKambmm2xTFrk6yTDOHl5o2NxETZ95iWqktE00rhDIxLwR++/E8D/8vfwoTvMY9KUlK
	GitPEUmFBA/nVRyIPQznrZIAu9EP6hsbCGifHiSgcSwKDpTrCKhRDwJoGc8loGG8AUBHyx8A
	f9t7SfjzyzwGu2YdOKyvHSFgb0s1CctMIwB2V1m5sFX5kYTvtH04tBn1BJxsWOdCq/YJDldK
	vOBUSTg0jTi4sKexlQPvDtUQUJdbAuBEqZkDDQ1iuPry8QZ6O0mG70FtWjuJaprSUVGBjUT5
	PQtcVNc+x0FN9YUEavpRRiJLxSqO2j6dQLfyFgm0PDuBo5UPCNV9XeIgte4aamx+j6P+mh4y
	0uUC72QiK5VksPIjYfE8cZ/eiMu0HlkzOjWmBOOuKuBEMXQQozX0kypAUQQtZMwdsZvYjd7P
	TDVOEyrAozB6icvMFdzEN4UrLWZKH61jmxvfiDQG6xbn08eYhaVyzvbNg8zT5xNb3Ik+xdyf
	toHNLaCdmW/PusB278JYK2e2Gozey+S16LBS4KzdobQ7VA3g1AM3SUpGskgiDfZXJImzUyRZ
	/gmpyU1g468Pr/698wr8sp0zAZoCQmd+AGGVCLiiDEV2sgkwFCZ04xdpzBIBP1GUfYWVp8bJ
	06WswgS8KFzozo+IZuMF9GVRGpvEsjJW/t9yKCdPJYg8PnY9p85S6Th/T62qOvPCt3lXiKa3
	0Gf4TWdov13WHlURVzec6Fc9ZMvu9pCGFefEpPt63g7h3aha3+dukAdfiolWcS3LyR0o0vy5
	8Ki3IcRnfc0rSPa9NmBRH+rReci4mHlWOeq1uy18NOLigwHlWprWW9mnjyxOOG0PzM8U4gqx
	KNAPkytE/wBtP38J0wIAAA==
X-CFilter-Loop: Reflected

On Thu, 26 Mar 2026 15:19:49 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> 
> 
> On 3/26/26 2:41 PM, Dave Jiang wrote:
> > 
> > 
> > On 3/26/26 1:54 AM, Rakie Kim wrote:
> >> On Wed, 25 Mar 2026 12:33:50 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> >>> On Tue, 24 Mar 2026 14:35:45 +0900
> >>> Rakie Kim <rakie.kim@sk.com> wrote:
> >>>
> >>>> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > 
> > <--snip-->
> > 
> >  
> >> Hello Jonathan,
> >>
> >> Thank you for the deep insight into the HMAT parser code. As you
> >> mentioned, considering the current state where node 1 is still
> >> registered as the initiator in sysfs despite the flag being 0, it
> >> seems highly likely that the kernel parser logic is not handling
> >> this specific situation gracefully.
> >>
> >>>
> >>>> Because both HMAT and sysfs are exposing abnormal values, it was
> >>>> impossible for me to determine the true socket connections for CXL
> >>>> using this data.
> >>>>
> >>>>>>
> >>>>>> Even though the distance map shows node2 is physically closer to
> >>>>>> Socket 0 and node3 to Socket 1, the HMAT incorrectly defines the
> >>>>>> routing path strictly through Socket 1. Because the HMAT alone made it
> >>>>>> difficult to determine the exact physical socket connections on these
> >>>>>> systems, I ended up using the current CXL driver-based approach.  
> >>>>>
> >>>>> Are the HMAT latencies and bandwidths all there?  Or are some missing
> >>>>> and you have to use SLIT (which generally is garbage for historical
> >>>>> reasons of tuning SLIT to particular OS behaviour).
> >>>>>   
> >>>>
> >>>> The HMAT latencies and bandwidths are present, but the values seem
> >>>> broken. Here is the latency table:
> >>>>
> >>>> Init->Target | node0 | node1 | node2 | node3
> >>>> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
> >>>> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
> >>>
> >>> Yeah. That would do it...  Looks like that final value is garbage.
> > 
> > Hi Rakie,
> > So I talked to the Intel BIOS folks and apparently for devices that are not hot-plugged (with memory ranges provided in SRAT), those HMAT values are the value for end to end and not just CPU to Gen Port. That's why they look so much bigger. So there are couple things we'll have to consider:
> > 1. Make sure that Intel, AMD, and ARM HMATs are all created the same way and this is the agreed on way to do this. Hopefully someone from AMD and ARM vendors can comment. We all should get on the same page for the CXL kernel code to work properly.
> > 
> > 2. Add code in the CXL driver to detect whether the range is in SRAT and then skip the end to end perf calculation if that is the case. 
> 
> After further talking to Jonathan, I don't think at least this part is an issue. The devices that are attached at boot do not have Generic Ports in the SRAT.
> 

Hello Dave,

Understood. I'm glad that the discussion with Jonathan helped clarify
the situation regarding the Generic Ports in the SRAT. Thank you for
the quick update on this.

Thanks again for looking into this so thoroughly and keeping me in the loop.

Rakie Kim

