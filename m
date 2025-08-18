Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA962206B1
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505677; cv=none; b=CgFxy1N7SH8AeNiFZz4U9DPdDvGowz3sTIMKOrvaITSXeONxDEZ5oARZDFyXth1hjdZ19NA9IUL94B5DwT5qeev6/aGeL3MR4zEdzJrK4NEVERliR2C+znSj+5Ldp4X5eoljvXqzzif8r+gXoq0ZV/EaqgiVOu2SVZFtLBtd+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505677; c=relaxed/simple;
	bh=rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8XkTrDBuUvsIsN0871AcQDiyerSPCp4hycqEdGqvoroPS0L6TaHIb7OLMsD/yczyIIjIwXyel9iTJu+rPSz/PZ1GChJxpHffcrmyej/ApQ+7ItzQgbTKB8RnoXcBc4TBbYj6KpKG0t6CkDTlWtBZ/DGC9DAvzjj8VpWZtnaJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pH0jjYJT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pH0jjYJT"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7xiWv004737
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 08:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=; b=pH0jjYJTAl7re29P
	eDXYy6doYRSC9/QrUBVDRGmaKfPZCRnt/27BpOESnbmKcDWYQWQE0TN4RjZHB26p
	r31MIs4hA2/C4q4WvJs0F/TcGgCHu/dmVO2NTsFUfLgXGYc273YerMZN4+uFW9F7
	hypGSTOfjNaHRAfD5yZE9ln9D4CBCF4ZoWT6/s894AJcWj4w2Ceci1tqrMg7FZ7T
	8nC/lLMKExRJTWRCvcqmfiA5ilpDfF1xh3HEHJXusTG+HZ4HJHr6VZH5d8Jd3MdY
	0E5ihcuWt8hBw0jAUsx0ZEQNIeQ0WCoiOmTnd4PZxYXj0A6xg9y5MRgUrzX0TcRD
	r1n2kA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7ux1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 08:27:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47174c65b0so8074262a12.2
        for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 01:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505673; x=1756110473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=;
        b=XhCAFxPDUtmi9HTeyyNrxCh9UgBnUWEoLdbQ2ZdYu7ChIrFdC2j+EYF/6D/vCVjm4w
         dEVqgaTkr39EUDShfAigLgnpvdIvUxy9dFYyQBUb0agwcmnk/7HhsunURb7pj/kWf9s0
         meUx9nZw+1sYWlxnd0lWc+w6pEAfXKQEwvCzlyYoQz8pdRJOwiSIlh6jgNFXHldHNNqJ
         5G1kYSPh32TFBdt3OKj3P0vHzQanP1eBpJPN2ShQXfrSX8ybvfYbYgArG5/QMqWkdHA0
         VkmzFzz4bd3X3TD/G/sD0+nx4yJz3IUF2WBkYKAqsze1SCaLJLcrl+EtHz2gjdzdtMnS
         9IOw==
X-Forwarded-Encrypted: i=1; AJvYcCXkpW/A9lnMhwQdcTrhN4fDchGYy/l3SICRZAy7LVBvEiyC698eHO3jUnFtU0AxJtFstWc9j1BYICY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxs97aEYkarcpgqhnFC+MhZGvzocChZ/Vwm2oxJhXYOlw5YbNa
	XiyReSXh6V+BgwvdJa9I9/ss5cNG7fg3p7PIMuWCIzergg7IeN+0NyiZ0ZPCtFr45+fjDfTNjb/
	gi/q6Sn2rnNyvbGxeL5DAvA0CwPnaOWvmX0fbeyCdtImtAxNsnYHUnSYshz/YGRtzvLzFY4aF/W
	Pr4mE+8yEMHNcYGdKeTR9kvL9z1a4jIz5puFuPQg==
X-Gm-Gg: ASbGncu9VgqgjHX4gd9lHhoLm5rO0eZOrgCHppAk6l+fzguBeu3E5Bl7GdzVaA+5pkI
	/nekyQ9Yzw7g++UOcxRCi4wJ8gU2YFuhemrDX6VcfR7s/bbqKGTizSESaEunJKvF6rDKzNU2ZxH
	fpcd3Oee+ia4+JxeKQpAhsVw==
X-Received: by 2002:a17:902:e842:b0:235:ed01:18cd with SMTP id d9443c01a7336-2446d99e6acmr165826845ad.44.1755505673486;
        Mon, 18 Aug 2025 01:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxmEX0bC4rGj0GsL0Ofny3nTaPHYYQ7bo5uu9L4GZIVv1jBDAAlTveYAPi+e7gAhEyyevMd3DrrsmVZDn0oyA=
X-Received: by 2002:a17:902:e842:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-2446d99e6acmr165826455ad.44.1755505673065; Mon, 18 Aug 2025
 01:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-numa_memblks-v1-1-9eb29ade560a@oss.qualcomm.com> <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com>
In-Reply-To: <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:57:41 +0530
X-Gm-Features: Ac12FXzcSoeiNhok4BzoYQfoalKvL5KSge90N69qQ3e47Ph8xq7Ih6FtZXa_xiM
Message-ID: <CALzOmR0C8BFY+-u-_aprVeAhq4uPOQa+f2L5m+yZH+=XZ2cv_w@mail.gmail.com>
Subject: Re: [PATCH] mm/numa: Rename memory_add_physaddr_to_nid to memory_get_phys_to_nid
To: David Hildenbrand <david@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXyRT+RtkhZcj+
 0Ftx29ohTJVuWKEt6ZtX092v10tUsPUqutq6HLzxBS6kCSp5pslO24Pl0O2QxbKXA9bqwqzZ3EQ
 twhAbcu2dGUdrmlWDPj5Blm3GhMNeFpnqo4IVi3OJzEpnTSq4AvNY/5RLtbAt+IA9saEGfKHQ5Z
 lcu9E4fNWv0Xjh5N148lGO+g2U+VDt7rGcMjo5FxbsUov0FbPoH5POTpqTfPW9hTV/WpNL1aejk
 RhJCFltiJ1HfGYitT2FQcX0USVi+yiK8F/TCVJVONqjiaNSJgCxNMopR2CRG5gR4kxSej/KVbC+
 pX0/OISvZsuvFrfED+9NlOVKmEg8Akn1lum29sJM+jkrjBrp4QrIiOrC2WcYo9aVpUPGoX2a4iW
 FDTrxZpS
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2e40a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=uSFNSxTeKwDZCnUuY58A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 69IoLaZWRtuYt8A8tnIWwEthkWDliV1C
X-Proofpoint-ORIG-GUID: 69IoLaZWRtuYt8A8tnIWwEthkWDliV1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

On Mon, Aug 18, 2025 at 12:29=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.08.25 08:41, pratyush.brahma@oss.qualcomm.com wrote:
> > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >
> > The function `memory_add_physaddr_to_nid` seems a misnomer.
> > It does not to "add" a physical address to a NID mapping,
> > but rather it gets the NID associated with a given physical address.
>
> You probably misunderstood what the function is used for: memory hotplug
> aka "memory_add".
Thanks for your feedback. I get the part about memory hotplug here but
using memory_add still seems a little odd as it doesn't truly reflect
what this api is doing.
However, I agree that my current suggestion
may not be the perfect choice for the name, so I'm open to suggestions.

Perhaps, something like "memory_add_get_nid_by_phys" may work here?
>
> This patch is making matters worse by stripping that detail, unfortunatel=
y.
>
>
> --
> Cheers
>
> David / dhildenb
>
Thanks and Regards
Pratyush
