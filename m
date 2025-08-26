Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08C352FF3
	for <linux-cxl@vger.kernel.org>; Tue, 26 Aug 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216739; cv=none; b=BXPzFkXCX+D++Ygej/yCKQ0nq1t59Y703k31BH0z3iJgLxzx5AA42XAq3L/5MCIlanPgVjqOAdsXujt9O+hxGhf/69t8FXpfMu6h5CYNleFeaOfW83PDcDlsafdMaXjpBpVJj2szFgTWjWjXelKhM3PiEVVN69YGXfbRC2ZRbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216739; c=relaxed/simple;
	bh=M8EHVrFCv7al3ZPsc5Z5WWYn3hXBTwoDyNLcMGt439U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlW/qTlgEAADBlONLOfc0rcb0U/RwIQr8+36KmhYqi3nRf/VPkg+c9IfQnG8jAENJ+ultVbdCVbZ+3d1iWUKjmstbNvJwGA5maFFwyPJHgwlgvlmjID+wwty4Jk8j9EkTObKjV5W0kQqZ59hOf/WR3KdogNIvnMAyuQnhPoadxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB8N351w7z6LDDK;
	Tue, 26 Aug 2025 21:56:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B5E861402EB;
	Tue, 26 Aug 2025 21:58:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 15:58:51 +0200
Date: Tue, 26 Aug 2025 14:58:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Olivi, Matteo" <molivi3@gatech.edu>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
Message-ID: <20250826145849.000022d7@huawei.com>
In-Reply-To: <DM5PR07MB3548AFCDDA3DC39F50EECBE0973DA@DM5PR07MB3548.namprd07.prod.outlook.com>
References: <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
	<20250110170150.00005446@huawei.com>
	<DM5PR07MB3548AFCDDA3DC39F50EECBE0973DA@DM5PR07MB3548.namprd07.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Aug 2025 02:38:34 +0000
"Olivi, Matteo" <molivi3@gatech.edu> wrote:

> Thanks for the thorough answer.
>=20
> Given this part of the answer:
>=20
> > The BIOS may have configured the CXL memory and done the work for SRAT =
and HMAT
> > to include that memory. =A0Or it may present HMAT to a generic port ent=
ry in SRAT and
> > leave the discovery of performance to the OS when it is setting up the =
memory
> > mappings etc. For now we present the data for the nearest initiator (cp=
u / cpu or other)
> > to the CXL memory. =20
>=20
> I have three follow-up questions:
>=20
> 1. Assume the OS, and not the BIOS, does the discovery. Then, the
> HMAT would not list the latency and bandwidth to the memory (only to
> the generic ports).

Correct.

> But the sysfs files with the latency for local
> target-initiators pairs would still have the "complete" latency to
> the memory (as discovered by the OS), right?

Exactly.

>=20
> 2. If it's the OS which does the discovery, what information does it
> use?=20

Several sources are combined with the firmware description to the port.
1 - Estimates of link latencies and bandwidths based on PCI information.
    That is, how many lanes, frequency, and the encoding over the wire.
2 - CDAT table access via DOE (mailbox in the PCI config space).  These
    provide latency and bandwidth from port to port on a switch and
    port to memory on a type 3 device.


> Does it rely on some firmware hardcoded values like the BIOS, or
> does it run some measurements (e.g. perform some memory requests and
> time them)?=20

Upstream Linux just uses the values that are discoverable from
firmware + device provided info (which is probably coming from device
firmware).=20

> In case it does measurements, how does that work for
> pooled memory that is physically, but not logically, plugged to the
> host (there's no way to issue memory requests to it)?
>=20

I gather other OSes sometimes do it by measurement in early
boot but you are correct in thinking that's tricky if no memory there
yet.

> 3. Regardless of whether the OS or the BIOS does the discovery,
> assume the memory is from a CXL pool that is external to the host. A
> portion of the latency will depend on the PCIe link that will have
> variable length (and thus latency).
Unless it is a very long link that doesn't make a significant difference
in practice, the serializing on and off a link with a fixed maximum
frequency is more important.

> There's no way the motherboard
> firmware can know that latency at boot time. Is the latency for the
> link accounted for in the HMAT (and the derived sysfs files)?

Assumes a zero latency wrt to the actual wire time, but the width
and speed of the link is incorporated.

Jonathan

>=20
> Thanks,
> Matteo Olivi.
> ________________________________________
> From:=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Sent:=A0Friday, January 10, 2025 12:01 PM
> To:=A0Olivi, Matteo <molivi3@gatech.edu>
> Cc:=A0linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject:=A0Re: How to programmatically discover online and offline
> memory and its latency and bandwidth from user space?=20
> On Wed, 8 Jan 2025 17:55:41 +0000
> "Olivi, Matteo" <molivi3@gatech.edu> wrote:
>=20
> > Hello,
> > I'm a PhD student working on orchestrator support for memory
> > disaggregation.
> >
> > I have some questions about how Linux presents CXL memory and its
> > performance characteristics to user space.
> >
> > 1. What is the simplest way for a user space program (with root
> > privileges) to learn the latency and bandwidth between each pair of
> > NUMA nodes (even non-CXL ones)? Are reading the HMAT and shelling
> > out to the cxl cli the only two options? I've
> > read https://docs.kernel.org/admin-guide/mm/numaperf.html=A0but AFAIU g=
iven a memory target those sysfs files only report the performance from the=
 local initiators. I care about each pair,
> > not just local ones. =20
>=20
> Unfortunately the interface indeed only presents a tiny part of the
> data in a full HMAT table. The original discussion on this a few
> years back concluded that was all that made sense until there was a
> clear use case for more complete data.
>=20
> HMAT doesn't have to be complete but I'd assume it normally is.
>=20
> >
> > 2. Is there a way to get the information question 1 asks for for
> > memory that is physically connected to the host, but logically
> > isn't? The ACPI
> > spec https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture=
_Platforms/NUMA_Architecture_Platforms.html#system-resource-affinity-table-=
definition states that
> > "The SRAT describes the system locality that all processors and
> > memory present in a system belong to at system boot. This includes
> > memory that can be hot-added (that is memory that can be added to
> > the system while it is running, without requiring a reboot)." I
> > interpret that to mean that if (CXL) memory is physically, but not
> > logically, connected to the host, the SRAT will still describe the
> > corresponding NUMA node. But what about the HMAT? The ACPI
> > spec https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture=
_Platforms/NUMA_Architecture_Platforms.html#heterogeneous-memory-attributes=
-information states that=A0 "
> > The static HMAT table provides the boot time description of the
> > memory latency and bandwidth among all memory access Initiator and
> > memory Target System Localities. For hot-added devices and dynamic
> > reconfiguration of the system localities, the _HMA object must be
> > used for runtime update." but it's unclear to me if that applies
> > only to physically hot-plugged memory or to logically hot-plugged
> > memory as well. =20
>=20
> The BIOS may have configured the CXL memory and done the work for
> SRAT and HMAT to include that memory.=A0 Or it may present HMAT to a
> generic port entry in SRAT and leave the discovery of performance to
> the OS when it is setting up the memory mappings etc. For now we
> present the data for the nearest initiator (cpu / cpu or other) to
> the CXL memory.
>=20
> >
> > 3. Is there a recommended way for a user space program to tell CXL
> > NUMA nodes from local NUMA nodes (both online and offline ones)?
> > One hack would be to check whether the NUMA node has CPUs or not.
> > Another option would be shelling out to the cxl-cli. =20
>=20
> In general not really. It's just memory, you should never care that
> it is CXL beyond that it's performance characteristics are different
> and maybe for error handling reasons. You can indeed use cxl-cli or
> reads of the sysfs entries that tool is using to figure it out.
>=20
> >
> > 4. Is there a way for a user space program (with root privileges)
> > to learn IDs of CXL NUMA nodes (both online and offline ones) that
> > are globally unique? What I want is: a. if two hosts are both
> > connected to the same CXL memory, they should see that memory with
> > the same ID. =20
>=20
> Look at serial numbers of the devices.=A0 That's not connected to NUMA
> node IDs that are local to a given host.=A0 Those can be obtained with
> lspci and are unique (assuming manufacturer set them - which
> sometimes doesn't happen in prototype parts).
>=20
> > b. two different CXL memory pools will never be seen with the same
> > ID by different hosts. =20
> ID here can't be NUMA node as those are used to index non sparse
> structures so it wouldn't scale.
>=20
> Once we get upstream support for DCD (only sensible way to do pools
> and remain compliant for the spec) and tagging of what that provides,
> then the globally unique ID will be associated with particular bit of
> shared memory on the device rather than the whole device. My guess is
> that will take a few kernel cycles though.
>=20
> >
> > All my questions talk about NUMA nodes. I understand that Linux has
> > multiple layers of abstractions to represent memory, and NUMA nodes
> > are one of the highest ones. If any of the questions above can be
> > answered but at a lower level of abstraction than NUMA nodes,
> > that's fine as long as there's a way to map the entity in the lower
> > level of abstraction to the corresponding NUMA node. =20
>=20
> Hope that helps a little!
>=20
> Jonathan
>=20
> >
> > Thanks,
> > Matteo Olivi.
> > =20

