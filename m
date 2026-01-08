Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44573164C2
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885334; cv=none; b=jMFhT11azKr6CWkcErjrusjzIPftFCpDoyaa39aYpdKhCDXH+2XBDR6hSxGmS0ZSe4NsegTruLmSgpPPWlL8/i5kz/fZhSaRZIr6Yt/GWQuw66ZI1uaYzOHioOc9XdNBjo7epQ10J5ltwVEXS5jtuhrYsd/ElJpgxu1UlBN7DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885334; c=relaxed/simple;
	bh=QWFzW8AiryxbX9bHsSDyy6FhwD+iu2OibSf5IcWI1Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eggl/cJoVTY5hE992rX6jpE0I2l45eV8My2IvEGvL175lZ+b4b7076AID7JylDzvJCoSw/p6lGSrprFtyH/Hne87u1FfvVOagvG/CdNoxqZnQIK0n+NAIMnQEErfzulGO5+3FjzY3CJaBpLDy1GUh55GHKl342HKaZobV8g8o/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5lKosHg; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5lKosHg"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6d13986f8so1642342a34.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885332; x=1768490132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcFV42Btb4Pg72+ADKdt3ZJAxf5GS4JhHeJgrxvwKog=;
        b=b5lKosHg7+ESgVswffeD5tWTkanPcq3h+ztzV6f/gXXm4nr6yyGM2b09SwLIZENljV
         NrcxpmR1Ev5aLcBPPP549QNjvWH+ocoWnC3eKnq3/Vo0C5oxpa1kbg8ODT55TM+c20BZ
         7ONWTknfNA7bkPfyhwpNnaOPHsKRzCNvOKA2gCt+K3NsmkA3elOWkOkNh7eUvlDBOC7p
         dX0eFSojRFSUXooJMp5DO+aA/6CdBzMHH0GGLpaYnNMFTFvQ8GUcW1oxicBHdzxsYrOD
         eui1PqmUFwlHvbhAgl3dlCBnive1VWuqBIifQT5oC+SpUnjVYTnnnJbVlkJ97Tariz/Q
         bYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885332; x=1768490132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcFV42Btb4Pg72+ADKdt3ZJAxf5GS4JhHeJgrxvwKog=;
        b=T1L1kBS4d+9zmLqlMx6d6IBhduvn3EpS/HcSki376aqzYv9v0nYspMEkvnuE40HE/G
         GaGka4+nCBxucwstkvqS+81TZyXDmXNTnLT9Fp0ZRSAP86pJtdZim26F2i1HayoRafkQ
         jIXj7fJ4Bwn3bQkCasw802uPwceHpFO6fIqNxB+Q7dh5gwZnDUHKeS7UQMBJnEvs8bpA
         udgrsicTmiJgv533Ma5ssPR88lLE5Jww5tYYyT10xNdP5u3+ZDKtwqAYvXoud5NEaRmD
         BhI3p/aHPMnfWybND7rGNRkhja8etDQGlfP43dX0gbeGtpxsHiDChrsEc6WTWrQ8K7WJ
         7QMA==
X-Forwarded-Encrypted: i=1; AJvYcCWqYIKU01LHu7Ffiu56UslKi8FZDez+BmFiCROvmpgqcN3YYiLgL/kinhNoa4HcePr79CY+2MZICkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdH9TmqiY6FeqHghA7QGA3slKvLfYgHsKJjZmEeSlI3t46RY6
	I7RX9hZY9V3B1/rucpjDgdVUpl24eVC0sVxT8WamFSiYJxYdn/TsriPB
X-Gm-Gg: AY/fxX5ClM4NdlXtqL2ukR9QSO45AWgA37KhqwLiYA8moh6TXLiyNBvF3huCkpBLC7w
	M9v7Nwz9ryr5grnQGFcyUcptgPfhyzBWJ13iRU8TiSEP7jDxIG90n4CM1LL8irAlXbnOB+zO+Jj
	CfAih8MGbE6xhgtww3Yeplg9jzSSJ92yTxSc9WltBPG1HiFNZH7btKbpxM6ngExKSdNgbGTerBo
	3jIs2yey3uUL5BcfjXSHo8b1Cq//f/YeGYjeCZf0m3PzzdeciVKoczO5ektiHLbiDNt0VRI35uE
	Vjp1z+3urtf44Y3tfMxRB1qJxdD1LTWeVo8kg28pv+TFg88qeLqHTsp/QBN4ubrJGwU+sT/IV2O
	jdQBW8LxZ2MBSfOzrV8kRjTfEahNYNIBoDWEasZlHOZZKobxrGcfqRWra+2lNzNip1u4KZX5Iyl
	+JOM/EF/WNaBBJvw9cQvi1RUvtxZuTgw==
X-Google-Smtp-Source: AGHT+IEwgFQoT6qI08G95oHchDEjjGEhvVdx57kWehu/9O96BbjgHzcPqrjy1Acp6iwhXUgPqgye5Q==
X-Received: by 2002:a9d:4c94:0:b0:7ce:5139:301b with SMTP id 46e09a7af769-7ce5139308emr2469509a34.8.1767885331763;
        Thu, 08 Jan 2026 07:15:31 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm5799755a34.8.2026.01.08.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:15:31 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 09:15:29 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 03/21] dax: Save the kva from memremap
Message-ID: <djiagki7jvoyonnr5ajt43xwasgil6j7sfjhs27gbb6uwckyds@i52ef23dwakh>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-4-john@groves.net>
 <20260108113251.00004f1c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108113251.00004f1c@huawei.com>

On 26/01/08 11:32AM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:12 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Save the kva from memremap because we need it for iomap rw support.
> > 
> > Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> > address from memremap was not needed.
> > 
> > (also fill in missing kerneldoc comment fields for struct dev_dax)
> 
> Do that as a precursor that can be picked up ahead of the rest of the series.

Makes sense. Actually, I'll just send it as a separate standalone patch...

Thanks,
John

[ ... ]


