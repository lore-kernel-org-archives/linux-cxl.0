Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A720B22;
	Mon, 30 Mar 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862708; cv=none; b=kUxsZvk+vSo707+RBG4rGGxkiHT4UiRkI9LkYdoFwytjT7BNHq1SpDUMqCk401B9O38ObjwxTGdn8JbrXuoqcUwrkng5AHgFQUmnuUCrCHbx6ssVHeZbKrxsXECl4Yw22q8kSr8Jp6IqgwyjWoXTGwQguGbDB7/MYTuDIWGTGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862708; c=relaxed/simple;
	bh=TcPN4wuQnvO23FjteD/mbC/fzfPKCFrw70kYOn9S9tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqMoKEndOcnbC/gk76vXlGWRuSM6HzH4CGyRplEuM3roxAl88BNWicM2FEaW1EX/ByP3LkhGNqT1lTBUyatkzAnSMX027nevMARYhWPcfnKqF0vHG2aKC/eYtkb2LKatkL6j/CkU2XZ83POtNvCzxwkKTfFAa17hpBosrYv70/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-b2-69ca41693796
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	akpm@linux-foundation.org,
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
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	harry.yoo@oracle.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Keith Busch <kbusch@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce socket-aware weighted interleave
Date: Mon, 30 Mar 2026 18:24:51 +0900
Message-ID: <20260330092455.411-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <acXjVmTLSi75elvo@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsXC9ZZnoW6W46lMg5XTGC3mrF/DZnH38QU2
	i103QiymT73AaHHiZiObxeqbaxgtnm/9xWjx8+5xdov7y56xWOx/+pzFYtXCa2wWx7fOY7eY
	dOgao8X2hgfsFudnnWKxuLxrDpvFvTX/WS1OzlrJYvGtT9rifp+DxZH125ksJl9awGYxu7GP
	0eLWhGNMFqvXZFjMPnqP3UHKY+esu+weCzaVenS3XWb3aDnyltVj8Z6XTB6bVnWyeWz6NInd
	48SM3yweOx9aevQ2v2Pz+Pj0FovH1Nn1Huu3XGXxOLPgCLvH501yAfxRXDYpqTmZZalF+nYJ
	XBmvH61jLvi7i6ni2sz97A2Ms68ydjFyckgImEi0d99hg7F3zToMFOfgYBNQkji2NwbEFBFQ
	lWi74g5SwSzQzSax5YE5iC0skCExYfl/ZhCbBahkz84r7CA2r4CxxPK7R5ggJmpKrNt4iwXE
	5hQwk3i2cjlYXEiAR+LVhv2MEPWCEidnPmGBmC8v0bx1NjNE7192icaNnBC2pMTBFTdYJjDy
	z0LSMgtJywJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgRG8rPZP9A7GTxeCDzEKcDAq8fAa
	sJ3MFGJNLCuuzD3EKMHBrCTC2z39WKYQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJ
	JanZqakFqUUwWSYOTqkGxlKv1caLmcuaIxdes0suvZxgJayvOD3A+buOouiuP4GbdSZ38ex6
	qV9hGj/52vYpQUVFJiKnJEtSK+rKKz+JfA9oP96u9vv0Cv5Cltu1F97fX7Wp/czS0Pk+zYf0
	iv4+3nrKvdbysn0JQ3uC97f5DAumtbr1NFTnVinY+bT99/MvUbywlWeHEktxRqKhFnNRcSIA
	YKVMOdwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYQCG/bazc87EwXENOmhgDUTs4oUsvyDKEPND+hElhCLkylM7uE3Z
	VLSSJpZUkk1zqJvJQtDU5Q3NpjNpzunE0rysVKZmqdkw00IwM3NJ4L+H9314/7wkV9iD+ZCs
	Io1RKiQyMe6JeZYGJBxhz/SzIYvaYFjeYMSh89MQDts/xMK3xXoclmiHAOwbz8Fh3bgRwIXW
	XwCuO3sJOF01j8Ef8y4u7JpbwGDtUwcOe1srCFhkcQDY/cTOg23qGQIO6voxONJejsMp4xYP
	2nU1GFwr8IXTBRHQ4ljgQWtDGwc+HjbgUJ9TAOCExsaBdUYp3HjxbDvqmSIi/JBJ5ySQoTkd
	5eeNEOiOdYmHKs2LHNRcex9HzatFBOor3cCQ6eMJ9DD3G45W5iYwtDaJUOWX7xyk1d9GDS1j
	GBowWInz3vGeJ5MYGZvBKINPJXpKXbP13NTNdk6mo6yLUAP9GHgA+CRNhdHtuu5tJkmcEtO2
	zgQ3iih/Om802m1wqXycbpkJd/MeSkprqre4bsa2FbNplHCzgDpKVzutnJ3FQLq+aQJzM586
	Ts/XVP/LhZQX/bWxC+z43rS97DO2s+9H57bquRrgpdtV6XZVBsCpBSJWkSGXsLJjQapkaZaC
	zQy6miJvBtvnVmX/LnwJfo5EWwBFArGXIAS3s0KeJEOVJbcAmuSKRYL8EhsrFCRJsm4wypTL
	ynQZo7IAXxIT7xXEXGIShdR1SRqTzDCpjPJ/yyH5PmrwLsZqH3ik6MkJk0aaXR2BLZN9pRXa
	lT91sTXWzY6lxlz+mjq9O/zKclSk6bUHOWk+F1dokKrW3+/PdrWZh5+zZ+tmkw6fvugKdbwa
	Kz50Ly6StEmexS2/EcnlAaslUaLBgbs+YuM1g81/3WPFj2q6pbmQH3JgnzboZm4n2xMvxlRS
	SehBrlIl+QsPriAc2AIAAA==
X-CFilter-Loop: Reflected

On Thu, 26 Mar 2026 21:54:30 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Tue, Mar 24, 2026 at 02:35:45PM +0900, Rakie Kim wrote:
> > On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > 
> > Init->Target | node0 | node1 | node2 | node3
> > node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
> > node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
> > 
> > I used the identical type of DRAM and CXL memory for both sockets.
> > However, looking at the table, the local CXL access latency from
> > node0->node2 (0x9C4) and node1->node3 (0x4268) shows a massive,
> > unjustified difference. This asymmetry proves that the table is
> > currently unreliable.
> >
> 
> Can you dump your CDAT for each device so you can at least check whether
> the device reports the same latency?
> 
> Would at least tell the interested parties whether this is firmware or
> BIOS issue.
> 
> sudo cat /sys/bus/cxl/devices/endpointN/CDAT | python3 cdat_dump.py
> 
> ~Gregory
> 
< --snip-- >

Hello Gregory,

Thank you for providing the python script. It was incredibly helpful.
I ran it across all the CDAT files found in my sysfs.

For context, my system currently has 16 CXL endpoints attached
(from `endpoint9` to `endpoint24`):
/sys/devices/platform/ACPI0017:00/root0/port.../endpoint.../CDAT

As Dave Jiang recently pointed out in this thread, the Intel BIOS
team confirmed that the HMAT values actually represent "end-to-end"
latency. By comparing these CDAT dump results (which show the
device-level latency) with the HMAT numbers, we should have a much
clearer picture of whether the massive asymmetry originates from the
device firmware itself or from the BIOS calculations.

I have attached the extracted CDAT dump results for the devices below.

Thanks again for your help in isolating this issue!

Rakie Kim


=== CDAT from endpoint16 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint20 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint18 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint17 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint14 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint10 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint23 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint22 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint15 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint11 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint12 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint19 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint13 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint9 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint21 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

=== CDAT from endpoint24 ===
CDAT Header:
  Length:     208 bytes
  Revision:   1
  Checksum:   0xc3 (OK)
  Sequence:   0

  [0] DSMAS  (Device Scoped Memory Affinity Structure)
    Offset: 16, Length: 24
    DSMAD Handle:  0
    Flags:         0x00 (None)
    DPA Base:      0x0000000000000000
    DPA Length:    0x0000002000000000 (128.00 GiB)

  [1] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 40, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     0 (Access Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [2] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 64, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     1 (Read Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [3] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 88, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     2 (Write Latency)
    Base Unit:     1000
    Entry[0]:      110 -> 110.00 ns (110000 ps)

  [4] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 112, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     3 (Access Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [5] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 136, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     4 (Read Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [6] DSLBIS (Device Scoped Latency and Bandwidth Information Structure)
    Offset: 160, Length: 24
    Handle:        0
    Flags:         0x00
    Data Type:     5 (Write Bandwidth)
    Base Unit:     1000
    Entry[0]:      45 -> 43.95 GB/s (45000 MB/s)

  [7] DSEMTS (Device Scoped EFI Memory Type Structure)
    Offset: 184, Length: 24
    DSMAS Handle:  0
    Memory Type:   0 (EfiConventionalMemory)
    DPA Offset:    0x0000000000000000
    Range Length:  0x0000002000000000 (128.00 GiB)

Summary: 8 entries
  DSMAS  (Device Scoped Memory Affinity Structure): 1
  DSLBIS (Device Scoped Latency and Bandwidth Information Structure): 6
  DSEMTS (Device Scoped EFI Memory Type Structure): 1

