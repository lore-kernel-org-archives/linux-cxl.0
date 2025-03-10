Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546F14A09E;
	Mon, 10 Mar 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595018; cv=none; b=GH9nLrPE5W1yQbTlFU8NfOHLnA+Qpv8Ui7LLPr6GbmIikBKHCzXTM3SrXbOnjv3xRT9OgPD+d1ShVE0+sGMkb+IK6mYa15ODs16le0rrlRUlg7mzI+lmisMuqIWo81zGtvM51PH9uUzUOCEjMnqyBcFnV+6j/A9Kr40rpdaOUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595018; c=relaxed/simple;
	bh=AjPlA6/0Vt2/ykNJB2kiR4TJT7iqwwM1ouKE+3LBPIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRKh3AJ82NqIWc+1dsM9wug1WMh5D/Ij5pizVg7b1Cto+61pKvA4KgW0FtvaTBIhQJWEJllCxoZHFbcYFvGv4SNPb9762Qtgz5CEetP4mextk29A0HPg6U+63KHk/+Hj+JKJODs25oop6PjWomVMQA9dft+fNPyzgOFBJ8ELSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-45-67cea17bf4e7
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH 4/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Mon, 10 Mar 2025 17:23:03 +0900
Message-ID: <20250310082313.584-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8sPjdXmFGO9-y7D@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC9ZZnkW71wnPpBlNPGljMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZfx4+ZO1oImj4tfDsAbGbWxdjJwcEgIm
	Ems/HmCBsX82PQeKc3CwCShJHNsbA2KKCKhKtF1x72Lk4mAWWM8k8XrTLLBWYYFAiVszvjKC
	2CxANWs2HAKL8woYS5xYu4wJYqSmRMOle2A2p4CZxMyTk8BWCQnwSLzasJ8Rol5Q4uTMJ2Bx
	ZgF5ieats5kheo+wSbxrUYSwJSUOrrjBMoGRfxaSlllIWhYwMq1iFMrMK8tNzMwx0cuozMus
	0EvOz93ECAzhZbV/oncwfroQfIhRgINRiYf3wbyz6UKsiWXFlbmHGCU4mJVEeNW2n0oX4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwFgf/OOKy4vsWyYp
	WdsXtqt/LZ67kHvtZd8FLGnStcvsyqrj3U5uy5DaO//V0o4LpdF7bPbt211erRoiYX+9O6lv
	RtRWW9as0gKG8EITyfqNmr8UNnj0xa6TuKz85ckJ+3M/r03mWLN4ZUZ/5cp913ZuTbsvxjpD
	pOvm323q7D3Xy+V6OM37W5RYijMSDbWYi4oTAQq63LVdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS7d64bl0g8971SzmrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGX8ePmTtaCJo+LXw7AGxm1sXYycHBICJhI/m54D2RwcbAJKEsf2xoCYIgKqEm1X
	3LsYuTiYBdYzSbzeNAusXFggUOLWjK+MIDYLUM2aDYfA4rwCxhIn1i5jghipKdFw6R6YzSlg
	JjHz5CQWEFtIgEfi1Yb9jBD1ghInZz4BizMLyEs0b53NPIGRZxaS1CwkqQWMTKsYRTLzynIT
	M3NM9YqzMyrzMiv0kvNzNzECA3dZ7Z+JOxi/XHY/xCjAwajEw/tg3tl0IdbEsuLK3EOMEhzM
	SiK8attPpQvxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUw
	VtfU1B424nN71FzTcenQ3Y1n2YWKjJpnZZ+2dq9hvLVrdtsrnvLansv/rr1UO3Kl7Xuqx5mL
	d3PtHTe2dKy9ZX3twqZn/TUu61J1TunGiB9ZKN/ULBHk0MB0+e+G7d+endz2wuf1Pvej32dV
	K2q3bE33LjULCpCZdUYg49v/uUFPjmzJSJ8uqMRSnJFoqMVcVJwIAPNFUWVYAgAA
X-CFilter-Loop: Reflected

On Fri, 7 Mar 2025 10:23:57 -0500 Gregory Price <gourry@gourry.net> wrote:

Hi Gregory

 On Fri, Mar 07, 2025 at 03:35:33PM +0900, Rakie Kim wrote:
> > Improper cleanup of sysfs attributes caused kobject and memory leaks when
> > initialization failed or nodes were removed.
> >
> 
> Is this fixing something in your patch set or fixing something in the
> current upstream code?  If in the current patch set, roll this into the
> patch that causes it.
> 
> If this is fixing something upstream, I recommend submitting this
> separately to stable and rebasing on top of it.

Thank you for your response regarding this patch.
This patch isn't a modification of my hotplug-related patch but rather
a fix addressing issues in the existing implementation of the commit
listed below.
I will proceed to update it as a separate patch based on the mentioned
commit.

mm/mempolicy: implement the sysfs-based weighted_interleave interface
(dce41f5ae2539d1c20ae8de4e039630aec3c3f3c)

Rakie

>
> 
> ~Gregory
