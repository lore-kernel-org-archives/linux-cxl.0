Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDB26F46F
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576483; cv=none; b=ldC46LvexU/e70XEAzsmiXAeAlqdKqvDD4rSjIzwS5hdeOQhalKzwERkYXxsUzrSoEu4Mw0/VIddGk/y34T7KkZIFjU6TE2gkCJEdfETRJq4VfQc3ZbaBbpW4oxAVVhXjtBue9WkpTkKayzcrUpdxyZmPvaHg2zSrDPsl6Q0q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576483; c=relaxed/simple;
	bh=XFUSQJuHNSiKa3I+V7dfD4Kz7OP9Hp4uxMPzx8g0BHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G031+/nkJ3kuK+5aXVQzfcZcUa5eMNelnTnNaY7/2RBt+Ps0pUEX5L1mXJx6z+9Z6s06VCMr39NbnMkQcoNsJuMuiG1tIQSWnh5bLBeZ7CdPln6XAUxw4GW0rqX5EmgoqAcmznXMxaE0hfqgcTT5tgCP19rllxfKyxLxGwHbHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FMdnhT6X; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FMdnhT6X"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b392f1846so26950451cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774576481; x=1775181281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9ir4uS8pdDADAw0FjDkX0LtrCef2MnWNMYpw/MLHP0=;
        b=FMdnhT6XfD1mtt5oeNa98wmuCNHt/MBKc7eqi0zwFAtIuYr0Tue2K3LgcqoRQcYYih
         ioYpzOU6/vV412fSo4FXDVOvkOrx7saDYP8cXf0G3Q594y1AgDM9Yc7I/R2y/xV0+ojr
         MPuBPs/wMxJVZKVwBS1FXo2jhi9awBdiM2PFMo072C8WJEAnR3B51alfVF6OFS27GlJB
         qo9+WJrmm/IzE/VO228ghubctaI7G5zUR/5qAbV34dFJ2/6YXw6OLkGBKODiO6Phcu66
         bwmmvzZ/OZrMBDGJow3CqVTUucm16I8K89t7IlXJdc+OnvFpxc+/W3Gm+KztA6jpIYfM
         RltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576481; x=1775181281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9ir4uS8pdDADAw0FjDkX0LtrCef2MnWNMYpw/MLHP0=;
        b=leYfA4dYlEWBzDXQFN2+kov8iXHYTYmVl2wMMmGDKJXz091p7OIHHu/UYrg7gQNI6a
         9WDTD/ZwIqGW/st8tBW06sysNSpIpHkMlGoDqT23GOONCXJRUBdDRw8UyB27cj+BAFYJ
         I2JggjicZKb2DUEiyTFH9xXRAjnFQjsJkzEsZei84E7NXetHfILnhnYsCCePU+6vOaAj
         TwiFU+P1mRzFe0xG6HozK/sGfQKAWlc3NsJOR2gyKymeAGX+p9k8xL8aDCgQtLX0EIld
         RDnYO3kgXNX1O0ikhxjJly0ATAxA9T1ntWxQfczHs20uZ4TJPvK7VT9o5lOiTCMBnzGp
         Q1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV3oP8/jLBVBLe1BytK25jHgJhooVJLiPfMWE5oy5m2YERTTkoZnMqD9EoXeo9t7E3fuZ7NHrMAe8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBev1ZEmO7P6rbln0l9e/h6EXWGI5+E2GzWvnQrZpLPRmXL3bK
	/3PXaNCI5cLc+AOvi0tiwklE4b0Sn8mLOFHEq13UXeLPzCTJkQM3gAb7OfaJISx0YNU=
X-Gm-Gg: ATEYQzxNE9Nt2Fi4YkIb/SaCEhmjKJQKOkYYmh0xAdiexLiPte1Iy3ogn4nyr71pkK6
	cxjAIYUg+cJMPUXvtZZV/ofwp9zXjIPgZDFGx85VQXNV8O7PRIX6BKKRjFSs0hTXO9mhE2Ucbi8
	pV9R4EVB/TgHfRvQ5dls5xuBdPch3rL+HsNZHN2OuzLQzeYs5i+tBKjmO/0PpSffrJk2lgzskep
	RcI7KrkriR6tBbSzfwuEKGmgJsJRnlcmJN0qL+c/l6RhfZ1eKSXMPj0Iw6VTzXqB2cDwF0LTC1j
	wWWPYSCJVBKT9xMHUinOViansKqDnW2tSuzuiHQ9q+5ezRelxaLNBl9BpYQDd/kCJjNIbDjWbk5
	FJ2cCZxRhebPbY9o7isM1Fjeoa1d+jN0icJJ1Jg+sfcoKBkXbHpQ74zWotrslHY+0Go4JT7/aDy
	TjosOq+7Jd4T0vaKTgTy/TWiC5tBFtXt8+2WK3sLwk6rWMTQ==
X-Received: by 2002:a05:622a:8:b0:509:2f5f:a178 with SMTP id d75a77b69052e-50ba3836481mr11501441cf.21.1774576480977;
        Thu, 26 Mar 2026 18:54:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b923c0fc1sm39030981cf.27.2026.03.26.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 18:54:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:54:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, harry.yoo@oracle.com,
	lsf-pc@lists.linux-foundation.org, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
Message-ID: <acXjVmTLSi75elvo@gourry-fedora-PF4VCD3F>
References: <20260320165605.000024c0@huawei.com>
 <20260324053549.324-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="crgR4+6E7f+z/zRp"
Content-Disposition: inline
In-Reply-To: <20260324053549.324-1-rakie.kim@sk.com>


--crgR4+6E7f+z/zRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2026 at 02:35:45PM +0900, Rakie Kim wrote:
> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> Init->Target | node0 | node1 | node2 | node3
> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
> 
> I used the identical type of DRAM and CXL memory for both sockets.
> However, looking at the table, the local CXL access latency from
> node0->node2 (0x9C4) and node1->node3 (0x4268) shows a massive,
> unjustified difference. This asymmetry proves that the table is
> currently unreliable.
>

Can you dump your CDAT for each device so you can at least check whether
the device reports the same latency?

Would at least tell the interested parties whether this is firmware or
BIOS issue.

sudo cat /sys/bus/cxl/devices/endpointN/CDAT | python3 cdat_dump.py

~Gregory

---



--crgR4+6E7f+z/zRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cdat_dump.py

#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
# Copyright(c) 2026 Meta Platforms, Inc. and affiliates.
#
# cdat_dump.py - Dump and decode CDAT (Coherent Device Attribute Table)
#                from CXL devices via sysfs
#
# Usage:
#   cdat_dump.py                          # dump all CXL devices with CDAT
#   cdat_dump.py /sys/bus/cxl/devices/endpoint0/CDAT
#   cdat_dump.py --raw cdat_binary.bin    # decode from raw file
#   cdat_dump.py --hex                    # include hex dump of each entry

import argparse
import glob
import os
import struct
import sys

# CDAT Header: u32 length, u8 revision, u8 checksum, u8 reserved[6], u32 sequence
CDAT_HDR_FMT = "<IBBBBBBBBBBI"
CDAT_HDR_SIZE = 16

# Common subtable header: u8 type, u8 reserved, u16 length
CDAT_SUBTBL_HDR_FMT = "<BBH"
CDAT_SUBTBL_HDR_SIZE = 4

# DSMAS (type 0): handle, flags, reserved(u16), dpa_base(u64), dpa_length(u64)
DSMAS_FMT = "<BBHQQ"
DSMAS_SIZE = 20

# DSLBIS (type 1): handle, flags, data_type, reserved, entry_base_unit(u64),
#                  entry[3](u16 x3), reserved2(u16)
DSLBIS_FMT = "<BBBBQHHHH"
DSLBIS_SIZE = 20

# DSMSCIS (type 2): dsmas_handle, reserved[3], side_cache_size(u64),
#                   cache_attributes(u32)
DSMSCIS_FMT = "<BBBBQI"
DSMSCIS_SIZE = 16

# DSIS (type 3): flags, handle, reserved(u16)
DSIS_FMT = "<BBH"
DSIS_SIZE = 4

# DSEMTS (type 4): dsmas_handle, memory_type, reserved(u16),
#                  dpa_offset(u64), range_length(u64)
DSEMTS_FMT = "<BBHQQ"
DSEMTS_SIZE = 20

# SSLBIS (type 5) fixed part: data_type, reserved[3], entry_base_unit(u64)
SSLBIS_FMT = "<BBBBQ"
SSLBIS_SIZE = 12

# SSLBE entry: portx_id(u16), porty_id(u16), latency_or_bandwidth(u16),
#              reserved(u16)
SSLBE_FMT = "<HHHH"
SSLBE_SIZE = 8

CDAT_TYPE_NAMES = {
    0: "DSMAS  (Device Scoped Memory Affinity Structure)",
    1: "DSLBIS (Device Scoped Latency and Bandwidth Information Structure)",
    2: "DSMSCIS (Device Scoped Memory Side Cache Information Structure)",
    3: "DSIS   (Device Scoped Initiator Structure)",
    4: "DSEMTS (Device Scoped EFI Memory Type Structure)",
    5: "SSLBIS (Switch Scoped Latency and Bandwidth Information Structure)",
}

HMAT_DATA_TYPES = {
    0: "Access Latency",
    1: "Read Latency",
    2: "Write Latency",
    3: "Access Bandwidth",
    4: "Read Bandwidth",
    5: "Write Bandwidth",
}

EFI_MEM_TYPES = {
    0: "EfiConventionalMemory",
    1: "EfiConventionalMemory (EFI_MEMORY_SP)",
    2: "EfiReservedMemoryType",
}

CACHE_ASSOCIATIVITY = {
    0: "None",
    1: "Direct Mapped",
    2: "Complex Cache Indexing",
}

CACHE_WRITE_POLICY = {
    0: "None",
    1: "Write Back",
    2: "Write Through",
}


def hexdump(data, indent="  "):
    lines = []
    for i in range(0, len(data), 16):
        chunk = data[i:i+16]
        hexstr = " ".join(f"{b:02x}" for b in chunk)
        ascstr = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        lines.append(f"{indent}{i:04x}: {hexstr:<48s}  {ascstr}")
    return "\n".join(lines)


def fmt_size(size):
    if size >= (1 << 40):
        return f"{size / (1 << 40):.2f} TiB"
    if size >= (1 << 30):
        return f"{size / (1 << 30):.2f} GiB"
    if size >= (1 << 20):
        return f"{size / (1 << 20):.2f} MiB"
    if size >= (1 << 10):
        return f"{size / (1 << 10):.2f} KiB"
    return f"{size} B"


def fmt_port(port_id):
    if port_id == 0xFFFF:
        return "ANY"
    if port_id == 0x0100:
        return "USP (upstream)"
    return f"DSP {port_id}"


def decode_latency_bandwidth(entry_val, base_unit, data_type):
    """Decode a DSLBIS/SSLBIS entry value into human-readable form."""
    if entry_val == 0xFFFF or entry_val == 0:
        return "N/A"

    raw = entry_val * base_unit
    if data_type <= 2:  # latency types (picoeconds -> nanoseconds)
        ns = raw / 1000.0
        if ns >= 1000:
            return f"{ns/1000:.2f} us ({raw} ps)"
        return f"{ns:.2f} ns ({raw} ps)"
    else:  # bandwidth types (MB/s)
        if raw >= 1024:
            return f"{raw/1024:.2f} GB/s ({raw} MB/s)"
        return f"{raw} MB/s"


def decode_dsmas(data, show_hex):
    handle, flags, _, dpa_base, dpa_length = struct.unpack_from(DSMAS_FMT, data)

    flag_strs = []
    if flags & (1 << 2):
        flag_strs.append("NonVolatile")
    if flags & (1 << 3):
        flag_strs.append("Shareable")
    if flags & (1 << 6):
        flag_strs.append("ReadOnly")
    flag_desc = ", ".join(flag_strs) if flag_strs else "None"

    print(f"    DSMAD Handle:  {handle}")
    print(f"    Flags:         0x{flags:02x} ({flag_desc})")
    print(f"    DPA Base:      0x{dpa_base:016x}")
    print(f"    DPA Length:    0x{dpa_length:016x} ({fmt_size(dpa_length)})")


def decode_dslbis(data, show_hex):
    handle, flags, data_type, _, base_unit, e0, e1, e2, _ = \
        struct.unpack_from(DSLBIS_FMT, data)

    dt_name = HMAT_DATA_TYPES.get(data_type, f"Unknown ({data_type})")

    print(f"    Handle:        {handle}")
    print(f"    Flags:         0x{flags:02x}")
    print(f"    Data Type:     {data_type} ({dt_name})")
    print(f"    Base Unit:     {base_unit}")
    print(f"    Entry[0]:      {e0} -> {decode_latency_bandwidth(e0, base_unit, data_type)}")
    if e1:
        print(f"    Entry[1]:      {e1} -> {decode_latency_bandwidth(e1, base_unit, data_type)}")
    if e2:
        print(f"    Entry[2]:      {e2} -> {decode_latency_bandwidth(e2, base_unit, data_type)}")


def decode_dsmscis(data, show_hex):
    dsmas_handle, _, _, _, cache_size, cache_attr = \
        struct.unpack_from(DSMSCIS_FMT, data)

    total_levels = cache_attr & 0xF
    cache_level = (cache_attr >> 4) & 0xF
    assoc = (cache_attr >> 8) & 0xF
    write_pol = (cache_attr >> 12) & 0xF
    line_size = (cache_attr >> 16) & 0xFFFF

    assoc_str = CACHE_ASSOCIATIVITY.get(assoc, f"Unknown ({assoc})")
    wp_str = CACHE_WRITE_POLICY.get(write_pol, f"Unknown ({write_pol})")

    print(f"    DSMAS Handle:  {dsmas_handle}")
    print(f"    Cache Size:    0x{cache_size:016x} ({fmt_size(cache_size)})")
    print(f"    Cache Attrs:   0x{cache_attr:08x}")
    print(f"      Total Levels:    {total_levels}")
    print(f"      Cache Level:     {cache_level}")
    print(f"      Associativity:   {assoc_str}")
    print(f"      Write Policy:    {wp_str}")
    print(f"      Line Size:       {line_size} bytes")


def decode_dsis(data, show_hex):
    flags, handle, _ = struct.unpack_from(DSIS_FMT, data)

    mem_attached = bool(flags & 1)
    if mem_attached:
        handle_desc = f"DSMAS handle {handle}"
    else:
        handle_desc = f"Initiator handle {handle} (no memory)"

    print(f"    Flags:         0x{flags:02x} (Memory Attached: {mem_attached})")
    print(f"    Handle:        {handle} ({handle_desc})")


def decode_dsemts(data, show_hex):
    dsmas_handle, mem_type, _, dpa_offset, range_length = \
        struct.unpack_from(DSEMTS_FMT, data)

    mt_str = EFI_MEM_TYPES.get(mem_type, f"Reserved ({mem_type})")

    print(f"    DSMAS Handle:  {dsmas_handle}")
    print(f"    Memory Type:   {mem_type} ({mt_str})")
    print(f"    DPA Offset:    0x{dpa_offset:016x}")
    print(f"    Range Length:  0x{range_length:016x} ({fmt_size(range_length)})")


def decode_sslbis(data, total_len, show_hex):
    dt, _, _, _, base_unit = struct.unpack_from(SSLBIS_FMT, data)
    dt_name = HMAT_DATA_TYPES.get(dt, f"Unknown ({dt})")

    print(f"    Data Type:     {dt} ({dt_name})")
    print(f"    Base Unit:     {base_unit}")

    # Variable number of SSLBE entries after the fixed header
    entries_data = data[SSLBIS_SIZE:]
    n_entries = len(entries_data) // SSLBE_SIZE

    for i in range(n_entries):
        off = i * SSLBE_SIZE
        px, py, val, _ = struct.unpack_from(SSLBE_FMT, entries_data, off)
        decoded = decode_latency_bandwidth(val, base_unit, dt)
        print(f"    Entry[{i}]:  {fmt_port(px)} <-> {fmt_port(py)}: "
              f"{val} -> {decoded}")


DECODERS = {
    0: decode_dsmas,
    1: decode_dslbis,
    2: decode_dsmscis,
    3: decode_dsis,
    4: decode_dsemts,
}


def decode_cdat(data, source="", show_hex=False):
    if len(data) < CDAT_HDR_SIZE:
        print(f"Error: data too short for CDAT header ({len(data)} < {CDAT_HDR_SIZE})")
        return False

    # Parse header
    vals = struct.unpack_from(CDAT_HDR_FMT, data)
    length = vals[0]
    revision = vals[1]
    checksum = vals[2]
    # vals[3:9] are the 6 reserved bytes
    sequence = vals[9]

    # Verify checksum
    cksum = sum(data[:length]) & 0xFF
    cksum_ok = "OK" if cksum == 0 else f"FAIL (sum=0x{cksum:02x})"

    if source:
        print(f"=== CDAT from {source} ===")
    print(f"CDAT Header:")
    print(f"  Length:     {length} bytes")
    print(f"  Revision:   {revision}")
    print(f"  Checksum:   0x{checksum:02x} ({cksum_ok})")
    print(f"  Sequence:   {sequence}")

    if show_hex:
        print(f"  Raw header:")
        print(hexdump(data[:CDAT_HDR_SIZE], "    "))

    if length > len(data):
        print(f"Warning: CDAT length ({length}) > available data ({len(data)})")
        length = len(data)

    # Parse subtables
    offset = CDAT_HDR_SIZE
    entry_num = 0
    counts = {}

    while offset + CDAT_SUBTBL_HDR_SIZE <= length:
        stype, _, slen = struct.unpack_from(CDAT_SUBTBL_HDR_FMT, data, offset)

        if slen < CDAT_SUBTBL_HDR_SIZE:
            print(f"\nError: subtable at offset {offset} has invalid length {slen}")
            break
        if offset + slen > length:
            print(f"\nError: subtable at offset {offset} extends past end "
                  f"(offset+len={offset+slen} > {length})")
            break

        counts[stype] = counts.get(stype, 0) + 1
        type_name = CDAT_TYPE_NAMES.get(stype, f"Unknown (type={stype})")

        print(f"\n  [{entry_num}] {type_name}")
        print(f"    Offset: {offset}, Length: {slen}")

        if show_hex:
            print(hexdump(data[offset:offset+slen], "    "))

        # Decode the subtable body (skip the 4-byte common header)
        body = data[offset + CDAT_SUBTBL_HDR_SIZE:offset + slen]

        if stype == 5:
            # SSLBIS has variable length, pass total subtable body length
            decode_sslbis(body, slen - CDAT_SUBTBL_HDR_SIZE, show_hex)
        elif stype in DECODERS:
            DECODERS[stype](body, show_hex)
        else:
            print(f"    (unknown type, raw data follows)")
            print(hexdump(body, "    "))

        offset += slen
        entry_num += 1

    # Summary
    print(f"\nSummary: {entry_num} entries")
    for t in sorted(counts):
        name = CDAT_TYPE_NAMES.get(t, f"Unknown ({t})")
        print(f"  {name}: {counts[t]}")

    if offset < length:
        trailing = length - offset
        print(f"\nWarning: {trailing} trailing bytes after last subtable")

    print()
    return True


def find_cdat_sysfs():
    """Find all CXL devices with CDAT attributes in sysfs."""
    paths = []
    for dev_path in sorted(glob.glob("/sys/bus/cxl/devices/*")):
        cdat_path = os.path.join(dev_path, "CDAT")
        if os.path.exists(cdat_path):
            paths.append(cdat_path)
    return paths


def read_cdat(path):
    """Read binary CDAT data from a sysfs attribute or file."""
    try:
        with open(path, "rb") as f:
            return f.read()
    except PermissionError:
        print(f"Error: permission denied reading {path} (need root?)")
        return None
    except OSError as e:
        print(f"Error reading {path}: {e}")
        return None


def main():
    parser = argparse.ArgumentParser(
        description="Dump and decode CXL CDAT (Coherent Device Attribute Table)",
        epilog="Without arguments, discovers and dumps CDAT from all CXL devices.\n"
               "Requires root access to read sysfs CDAT attributes.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "path", nargs="*",
        help="Path to sysfs CDAT attribute or raw CDAT binary file",
    )
    parser.add_argument(
        "--raw", action="store_true",
        help="Treat input as raw CDAT binary file (not sysfs)",
    )
    parser.add_argument(
        "--hex", action="store_true",
        help="Include hex dump of each entry",
    )
    args = parser.parse_args()

    paths = args.path

    # Read from stdin if piped or explicitly given "-"
    if not sys.stdin.isatty() and not paths:
        data = sys.stdin.buffer.read()
        if not data:
            print("Error: no data on stdin")
            return 1
        return 0 if decode_cdat(data, "stdin", show_hex=args.hex) else 1

    if paths == ["-"]:
        data = sys.stdin.buffer.read()
        if not data:
            print("Error: no data on stdin")
            return 1
        return 0 if decode_cdat(data, "stdin", show_hex=args.hex) else 1

    if not paths:
        paths = find_cdat_sysfs()
        if not paths:
            print("No CXL devices with CDAT found in sysfs.")
            print("Check that CXL devices are present and the cxl_port driver is loaded.")
            return 1

    ok = True
    for path in paths:
        data = read_cdat(path)
        if data is None:
            ok = False
            continue

        if not data:
            dev = os.path.basename(os.path.dirname(path)) if not args.raw else path
            print(f"{dev}: CDAT is empty (read from device failed at probe time)")
            ok = False
            continue

        source = path
        if not args.raw and "/sys/" in path:
            source = os.path.basename(os.path.dirname(path))

        if not decode_cdat(data, source, show_hex=args.hex):
            ok = False

    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

--crgR4+6E7f+z/zRp--
