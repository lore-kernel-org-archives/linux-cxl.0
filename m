Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943EC242D70
	for <linux-cxl@vger.kernel.org>; Tue,  5 Aug 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404330; cv=none; b=VkGn88WqZjgt7AcnffnpqupUUCKJV0nK995pb53/EuJt1YX1MhbeG2oIMsC1BLmAtlyc9f4ZGaDBikopMal/N3SMkLIXLYAth0wXZV7FOLQXRiUrfbRaalN+pbCGys+Vmm3MLgIEqZu8TdrPJe4rPJGeSlFLTc3vHcC61NNTCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404330; c=relaxed/simple;
	bh=uOt9VJUUggxj+RGUY3I8WMeGr5NEpqhfKN5lq4AsbAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDX4oZBuK8HSoNm6zQxxX7HUbS18I/XpRdf5ZTm0t4rLFCo4BovT+zu2qxvby7YOxR3WoWAldMFtcXdtS69cWgE1a9gGqCsxvHwEOCnlh2aiUdfETxJe+UtY3sVXJQc3Wdk4HzGw4Enf4djKbpvMHjGeR0VztSCkCVGeKiGk1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=HRlnhohr reason="key not found in DNS"; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="HRlnhohr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:
	Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=mZ
	dt2NjpVooNPplxcfxbCJoav4+Wccn3SeeTLnjY7Og=; b=HRlnhohrFcfGJ7yFWJ
	7evd6btj0r55MFjci4AGLThtsFtOFSWZnlMJj+WYxUnbWJL1fKF5kNassr/t/XXE
	fCm5fZaEY3ygEdPv3JUN0x0gZeQ/05Q5XGzg5p+dMGVuCwexMRIMkzLNSwGbNoBb
	+eDEkiwbKBouja2+9FFRG8+bw=
Received: from localhost (unknown [139.227.252.237])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgDnr2TIFZJoHpAtAA--.36096S2;
	Tue, 05 Aug 2025 22:31:36 +0800 (CST)
Date: Tue, 5 Aug 2025 22:31:36 +0800
From: peng guo <engguopeng@buaa.edu.cn>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [RESEND] hw/cxl: fix the determination of illegal physical
 addresses
Message-ID: <aJIVyK7PPJdlsv4B@gp-VMware-Virtual-Platform>
References: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
 <20240823161434.00004b30@Huawei.com>
 <4ylhz5gnwatapw2nwu6ktgr6i6l4iwyxirg7yamimsvilh2jla@d7vkuddno4z2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ylhz5gnwatapw2nwu6ktgr6i6l4iwyxirg7yamimsvilh2jla@d7vkuddno4z2>
X-CM-TRANSID:Nyz+CgDnr2TIFZJoHpAtAA--.36096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7Wr4rXrWkWw17Cry7trb_yoWrJryUpr
	Z3KF4avw18Xa9rCws2qw1rX3y5C397trWq9r90vw1DXrn0gr1rAF17tayI9as8X34xXF1r
	Zr1jgwsxJa45AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCF04k20xvE
	74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1KZJUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

On Wed, Sep 04, 2024 at 01:01:55PM -0700, Davidlohr Bueso wrote:
> On Fri, 23 Aug 2024, Jonathan Cameron wrote:\n
> > On Mon, 19 Aug 2024 20:03:17 +0800
> > peng guo <engguopeng@buaa.edu.cn> wrote:
> > 
> > > When physical address range in the input payload of scan media command
> > > exceeds static_mem_size but does not exceed the sum of static and dynamic
> > > memory, the scan media mailbox command unexpectedly returns an error code
> > > which is CXL_MBOX_INVALID_PA.
> > > 
> > > This patch determines whether the physical address is valid in two cases.
> > > If dynamic memory exists, check whether the address range of the request
> > > exceeds the range of static memory and dynamic memory.If dynamic memory
> 							 ^ space for a new sentence
> > > does not exist, then check whether the address range of the request
> > > exceeds the static memory size.
> > > 
> > > Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd support")
> > Is that the right one, this code is affecting cmd_media_scan_media()
> > not the capabilities one which always limits to static_mem_size and
> > hence also looks wrong.
> 
> Yeah it is the right one - both commands were merged together (and
> yes, they both need to be updated for dcd).
> 
> Maybe have a helper to consolidate all cases where such ranges are used?
> 
> uint64_t ct3d_get_total_size(CXLDeviceState *cxl_dstate, CXLType3Dev *ct3d)
> {
> 
> 	return cxl_dstate->static_mem_size + ct3d->dc.total_capacity;
> }
> 
> > 
> > > Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> > 
> > As with the other patch, this needs to go to qemu-devel list
> > + both should have gone to Davidlohr as author the patch you
> > are fixing (sort of it, it's mostly down to what order patches
> > landed in I think).
> > 
> > Fan, Davidlohr, do we want to just cover the DCD regions as
> > well with all the scan_media commands?
> 
> Yeah, I think so - particularly since poison management already
> considers dcd for CXL_MBOX_INVALID_PA.
> 
> Thanks,
> Davidlohr

Hi Jonathan, Davidlohr,

Sorry for the late reply.

I’m following up on the discussion about the `scan media` command behavior 
when dynamic memory is present. Based on our earlier exchange, it seems 
that the command currently returns `CXL_MBOX_INVALID_PA` if the requested 
address falls within the dynamic memory region — even though this should 
be a valid case when DCD is enabled.

Just to confirm: should this be treated as a bug that needs to be fixed with 
an updated patch?

If so, I’d be happy to prepare a new version and send it to the proper recipients.

Thanks again for your feedback.

Best regards,
Peng Guo

> 
> > 
> > 
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 3ebbd32e10..b23c6b9b0b 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
> > >      }
> > >      query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
> > > 
> > > -    if (query_start + query_length > cxl_dstate->static_mem_size) {
> > > -        return CXL_MBOX_INVALID_PA;
> > > -    }
> > > -    if (ct3d->dc.num_regions && query_start + query_length >=
> > > +    if (ct3d->dc.num_regions) {
> > > +        if (query_start + query_length >=
> > >              cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
> > > +                return CXL_MBOX_INVALID_PA;
> > > +            }
> > > +    } else if (query_start + query_length > cxl_dstate->static_mem_size) {
> > >          return CXL_MBOX_INVALID_PA;
> > >      }
> > Can we not rely on dc.total_capacity == 0 if num_regions == 0/
> > 
> > > 
> > 

