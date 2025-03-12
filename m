Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9829E1DB356;
	Wed, 12 Mar 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767529; cv=none; b=nhG9Rn7vlXc6hlbvl1NqvpymsXxdZu+YbMYGPN5ZgNKosqxBuX4HXuGy5JV0VSqJMsRia5O6M0nzhr8F5wVI357uS5dkxzumm6FS01ePdakEaCTntKjkbNvReaoohyy0TMf+iVMIO31RLQc5rbH0jQbUPVRRBT/cgYaRTkwxMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767529; c=relaxed/simple;
	bh=Y9Oz+IZbOUM2+x/HvSwyP9LZmB89nzhbPQ65rCT8kAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuNlJOcRVYtsDReXMfWM4DNyAVpoNb8X6IZSQ+3FdXwwW5GoL5YkVcay5QMhKwzg/tOxkJTrIh/KTaRdJkRjaUB5fZoLSdilk8qNMFhqT9GCUd3Hbeop5CF8uAkR5kpsaPcLoA9z+/Lp1YFkEhxIAYAr3jL1e6E3FHSzPuPubTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-9d-67d14360e15c
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
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted interleave
Date: Wed, 12 Mar 2025 17:18:21 +0900
Message-ID: <20250312081836.665-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z87zpg3TLRReikgu@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnkW6C88V0gz9LLC3mrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mm5fPMBS8FOkYtqxe0wNjKcEuhg5OCQE
	TCTaZhV3MXKCmbeuvmYHCbMJKEkc2xsDYooIqEq0XXHvYuTiYBZYzyTxetMsNpByYYEIiadn
	WlhBbBagmts/HzOD2LwCxhK9p+awQYzUlGi4dI8JxOYUMJN403uEHcQWEuCReLVhPyNEvaDE
	yZlPWEBsZgF5ieats5lBlkkInGGTmLNzJtQgSYmDK26wTGDkn4WkZxaSngWMTKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAoN4We2f6B2Mny4EH2IU4GBU4uEVyLmQLsSaWFZcmXuIUYKDWUmE
	d7UtUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOj7gNG
	/43qzp7B7xfZVzjVMjyImCBz/OI5pXd6JfFfVxxRzWXl+/WEz21RwFwJ9fqZGkJZj07fOXP0
	DovJ0cd3V9adWiWwxVbogFbgEYVZqsKvL58+3vnmnmeBUXF/UeJa/8uve9XUu+ovCazq5Ci8
	VSCy7pB1nWPM6ZXb13VMu1a39sSexov8SizFGYmGWsxFxYkAX0UZtl4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNSzfB+WK6wfwnRhZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDJuXzzAUvBTpGLasXtMDYynBLoYOTkkBEwkbl19zd7FyMHBJqAkcWxvDIgpIqAq
	0XbFvYuRi4NZYD2TxOtNs9hAyoUFIiSenmlhBbFZgGpu/3zMDGLzChhL9J6awwYxUlOi4dI9
	JhCbU8BM4k3vEXYQW0iAR+LVhv2MEPWCEidnPmEBsZkF5CWat85mnsDIMwtJahaS1AJGplWM
	Ipl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBobus9s/EHYxfLrsfYhTgYFTi4T2geiFdiDWxrLgy
	9xCjBAezkgjvalugEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwT
	B6dUA+PJ6BxDRcXPHTP2REzS/fZGwSGNZUJPJIeQ1zGHXW3JNYnPbhv3bCusWjfNwKGr++Zc
	09MvJ18oatkcFtHbtrr96NRvka9jj36Ys1xH6dtnLfF3CXf0Qlt9Xr9MFr+iJ+a1tnnPv3O5
	+62Ms5MatH733exN+fd4X47z4+qL//aemTDXkfFPRasSS3FGoqEWc1FxIgDli6M4WQIAAA==
X-CFilter-Loop: Reflected

On Mon, 10 Mar 2025 10:13:58 -0400 Gregory Price <gourry@gourry.net> wrote:

Hi Gregory,

I have updated version 2 of the patch series, incorporating the feedback from
you and Joshua.
However, this version does not yet include updates to the commit messages
regarding the points you previously mentioned.

Your detailed explanations have been incredibly valuable in helping us analyze
the system, and I sincerely appreciate your insights.

> 2) We need to clearly define what the weight of a node will be when
>    in manual mode and a node goes (memory -> no memory -> memory)

Additionally, I will soon provide an updated document addressing this and
other points you raised in your emails.

Thank you again for your guidance and support.

Rakie

> On Mon, Mar 10, 2025 at 06:03:59PM +0900, Rakie Kim wrote:
> > On Fri, 7 Mar 2025 16:55:40 -0500 Gregory Price <gourry@gourry.net> wrote:
> > > On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> > > > 
> > > > I think the underlying issue you're dealing with is that the system is
> > > > creating more nodes for you than it should.
> > > > 
> > > 
> > > Looking into this for other reasons, I think you are right that multiple
> > > numa nodes can exist that cover the same memory - just different
> > > regions.
> > > 
> > 
> > I understand your concerns, and I agree that the most critical issue at the
> > moment is that the system is generating more nodes than necessary.
> > We need to conduct a more thorough analysis of this problem, but a detailed
> > investigation will require a significant amount of time. In this context,
> > these patches might offer a quick solution to address the issue.
> > 
> 
> I dug into the expected CEDT / CFMWS behaviors and had some discussions
> with Dan and Jonathan - assuming your CEDT has multiple CFMWS to cover
> the same set of devices, this is the expected behavior.
> 
> https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205
> 
> Basically your BIOS is likely creating one per device and likely one
> per host bridge (to allow intra-host-bridge interleave).
> 
> This puts us in an awkward state, and I need some time to consider
> whether we should expose N_POSSIBLE nodes or N_MEMORY nodes.
> 
> Probably it makes sense to expose N_MEMORY nodes and allow for hidden
> state, as the annoying corner condition of a DCD coming and going
> most likely means a user wouldn't be using weighted interleave anyway.
> 
> So if you can confirm what you CEDT says compared to the notes above, I
> think we can move forward with this.
> 
> ~Gregory
