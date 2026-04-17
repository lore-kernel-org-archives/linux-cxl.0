Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C928726E
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408394; cv=none; b=a4oaEyFMEseM2s+rBXGyvjiR++1U8OHpHhG+RSop7W5vwsGyDRP+zElpl/FVs/wJqbcJRbc6qQkYG1jRkeDVP6F3yLqyN3BREMznkVUC6zzOv/qGbrY34xo54y+80ABlPi8IXiDkqidQ8n8tVzFuekFHWkUbGPTxHsvVaj+4Uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408394; c=relaxed/simple;
	bh=d4PpKCk3+cY+Ia63Uy2Vt+eoNLKg4rm4l23ANxaSUh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laTxqn5T4OEAKyZFc3524fQc1qktFdvjQiPEfXJvpBMa1/zZg4mUF0UyaOGxVEZrZIkiM/lAMP9tq+TSC1cRIjafvSFzTn+28iD3zHzKKZA54kMtl+6V54WH5t9dQhSxQu9OzPbwsVIy8ecgLeMlTZHQcs4JHHNTMvrH1GBQew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G6TWVyi7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G6TWVyi7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb40149037so34244085a.2
        for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776408392; x=1777013192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhIjuJ3A3M20AFrPa5BfGVCAhbvvigIUz2GsEPa7gR8=;
        b=G6TWVyi7A+bojIeIPu6SwEfEYSmy3x7RRUApMxRyyuVrRZ1cHPp+Ni1hEoNJF7O4G5
         BVaj81i+xGeRdkhdmTeChTdi/FzS8fK+wTz1W18hSpNyTc/FBIGpU60ilWXAPVtPuZ8R
         P2ruTgGTk+Zo0DZdo9wZBo330WAdwdhBt/4xUpWzvBu/BH7Sd5FiWESWJiAZu3ibSl7v
         KqB7jbhVuKjavGYk9zC2EebvCD4GoJDHEwBI+kB0V0CNlviVK0UXgIDHvNaQTRqKhihX
         1aZJHYnG0lnlEGhH8HgAT7aHfRc6mB/rA2CSza3Kr+gTiz7OsROULxfSS46qC7ZsG2SS
         lpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408392; x=1777013192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhIjuJ3A3M20AFrPa5BfGVCAhbvvigIUz2GsEPa7gR8=;
        b=jhrrbtTmaJmfiGIOi68li7buav23JDXAcmm0RdXUxAqV63fTKLXI9Rv9ZGc2yliTi0
         ywSFi2Q6COiEQhAzSO5tTuRoBa/Z0shgzOGXuPw3CA2oVQ+lKC4qPqzYRJbzVHTKuIyi
         UAlJmlo+swbhXqxvNCcnAClss5LlNlOXsSg7pd4RbWxgvYrL3Kzoktqxua3F0IfWu5vv
         Y9K15mV24Rsyo5O/0sd/jVmFV7CdniAqQi4EgTjiW8gAGCzcdNUsCvvfcOb0P+0V5rdp
         MBh2qTqU7fevbMDtsGqyd2uH6FJb5fUhhOvSYGJnZNYgh851kz8tK517Zlj9juf2Sz5c
         fO8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9LScGPmVmdA9KnlcrYBfbASpPGpQ/5YDXOqZi9mt8l40JU6ro1aGJefY6e/y8IW8D1H+lbMoeZTdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnJ0zOpaOGSG07uTFtYs2z1aVYDYlyy4vt2ipopkZj1MJD9pa
	kfGYtbO9rKNaqQpXHxGcbT3gcdhb4OJgv+o2fKzc7cNAfHJA2necD02OQ5IIeUM1oSE=
X-Gm-Gg: AeBDieviRQI59OqK2Yt3qUp68FjPHSsCm5OKXp6gf8dAbC4ePddLwLsIEb3j5WrggvQ
	Um5Q4sHoQnSyIqxtYITq9jck8tTnJTfQqEXQeFyyjzGRh2AxV/lAVzqq0+3Jhn96xF4t9WBIAFP
	pfr+/HZMXLYz63Q0yyL7syykqErqlOLd6dnfFxXf6NO4NE859Hk99oOB0MUhHIKFyea5Xvq6eA/
	UIxuJX7Kz1xATxoMd9gf47tTBX+PxoAnBlLx+rZXokqGqH7g54UdBjqTZ+GCbm/kxkt+fp7Vr+y
	a+xDJSRidoJXerNklrTWeDyPNHCcdZM9wA3PUbSLWTvOOcfcr8d0TN0xO7nf+WI6feuLQToOEZr
	ib2SuV7LmiW4/2QU9PDapLuMCLnH8ec/cr+25C7a/NSIPbPG54LtoW0B484COJLfzShMCq6ZEDL
	8eY0rvEDUru0HP4vC8v4AWdkCyX604MYUvhzh5wvC9UTDZvIpYL17HDSpVakHI7uAxxJnU50FtN
	z6SwB/+jFPDx6xP2v66oahG8YDmI14=
X-Received: by 2002:a05:620a:4690:b0:8cd:92c5:b3e7 with SMTP id af79cd13be357-8e790407b72mr203408385a.18.1776408391906;
        Thu, 16 Apr 2026 23:46:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm42616985a.36.2026.04.16.23.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:46:30 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:46:27 -0400
From: Gregory Price <gourry@gourry.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>, "Darrick J. Wong" <djwong@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	djbw@kernel.org
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <aeHXQ2EW2ivlLb_N@gourry-fedora-PF4VCD3F>
References: <adlBcwJjLOQDAR65@groves.net>
 <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net>
 <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F>
 <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>

On Thu, Apr 16, 2026 at 06:24:02PM -0700, Joanne Koong wrote:
> On Thu, Apr 16, 2026 at 1:14 PM Gregory Price <gourry@gourry.net> wrote:
> >
> > I worry that this discussion is going to turn towards implementing a
> > solution grounded in parsing arbitrary formats and how to store them,
> > and that is completely detached from why FAMFS went this route in the
> > first place.
> >
> > I question whether the actual issue here lies in the interface APPEARING
> > more general purpose than it actually is - and therefore inviting
> > attempts to over-genericize it.
> 
> Would you mind clarifying this part? Are you saying that the interface
> and logic is *already* generic and usable for other dax-backed
> servers, just that everything is *named* famfs but it's not really
> famfs specific? 

Yes.

If you just find/replace "famfs" with "dax_iomap", the structures
here don't really seem all *that* crazy specific - they're just
optimized for memory speeds instead of I/O.

There is a circular nature to this - FAMFS figured it out first, in
what we think is a reasonably generic way, but we can't know for sure.

John, Dan, and Darrick have all proposed reasonable ways to hedge
against the obvious fact the interface will not be perfect - which
incorporates your BPF proposal along with a reasonably straight forward
deprecation path that's not always possible in other arenas.

All that while solving a real (and novel) problem.

That's actually pretty damn cool.

I would urge you to consider these proposals earnestly.

~Gregory
